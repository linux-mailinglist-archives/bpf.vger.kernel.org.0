Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B166A8BE4
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 23:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCBWfg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 17:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCBWfg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 17:35:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9AD4C6F4;
        Thu,  2 Mar 2023 14:35:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B933B811EF;
        Thu,  2 Mar 2023 22:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF6AC433EF;
        Thu,  2 Mar 2023 22:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677796528;
        bh=tUyw0AY7oMULtmvxSFUaSnVpS+zW4iVINchd0EaRh4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QIgg/1/8lfJfG58syf+xFKaD7LhK1v3N5Ew2fWsoWX6ipNifRH58Ye+3X8oy99h8m
         K2v0YdVaYzxZFoI2NMgPOAEaBg59MXRAuTLz8TvEho1opDN10P91qLlhifF/bcRoKE
         I0jrUyi+FRiCWifIP30JNlwN1wQxppabrXysyi3MhbaXMKwfSSn1FI++KVQUElTu5r
         WyJM6ki4rur4sxAKnJluCF/wKsdszyDHKm8hTkPzJCZ6JwXL4s77I5SalGwkg/6wKr
         bcI7OzZmqrJOQTaTKX7QQ4qKXVRu6nYDf3OX7dcipVoV2bh7WeslZFbM0buiFuVDTd
         IDMOVtixM1esQ==
Date:   Thu, 2 Mar 2023 14:35:27 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <kees@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        bpf@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: splat in ikheaders_read (bpftrace)
Message-ID: <20230302143527.4bee6f7e@kernel.org>
In-Reply-To: <20230302141231.2c0a3761@kernel.org>
References: <20230302112130.6e402a98@kernel.org>
        <22EA7360-E2FC-4A23-BF0B-EFDE523F9605@kernel.org>
        <20230302140814.294aece0@kernel.org>
        <20230302141231.2c0a3761@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2 Mar 2023 14:12:31 -0800 Jakub Kicinski wrote:
> On Thu, 2 Mar 2023 14:08:14 -0800 Jakub Kicinski wrote:
> > Mm. Actually stopping to look at the code - I don't see it bound
> > checking against kernel_headers_data_end :| Maybe we need:
> >=20
> > @@ -34,6 +35,7 @@ ikheaders_read(struct file *file,  struct kobject *ko=
bj,
> >                struct bin_attribute *bin_attr,
> >                char *buf, loff_t off, size_t len)
> >  {
> > +       len =3D min_t(size_t, kernel_headers_data_end - kernel_headers_=
data, len);
> >         memcpy(buf, &kernel_headers_data + off, len);
> >         return len;
> >  } =20
>=20
> Scratch that, the size is set at init time.
> My guess was memcpy() thinks the size of kernel_headers_data
> is 1 since it's declared as char?

Like this?

---->8--------------------

=46rom 7549153017144281c2475d9370962ad4d0ea8d4c Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 2 Mar 2023 11:15:53 -0800
Subject: [PATCH] kheaders: use a flex array for the symbol

Kernels with hardened copy hit:

    detected buffer overflow in memcpy
    kernel BUG at lib/string_helpers.c:1027!
    invalid opcode: 0000 [#8] SMP KASAN
    CPU: 1 PID: 1094 Comm: tar Tainted: G      D            6.2.0-12879-g04=
0b4d2ce1ad #646
    RIP: 0010:fortify_panic+0xf/0x20
    [...]
    Call Trace:
     <TASK>
     ikheaders_read+0x45/0x50 [kheaders]
     kernfs_fop_read_iter+0x1a4/0x2f0

Repro:

 $ cat /sys/kernel/kheaders.tar.xz >> /dev/null

Fixes: 43d8ce9d65a5 ("Provide in-kernel headers to make extending kernel ea=
sier")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 kernel/kheaders.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kheaders.c b/kernel/kheaders.c
index 8f69772af77b..90562eb4093a 100644
--- a/kernel/kheaders.c
+++ b/kernel/kheaders.c
@@ -26,7 +26,7 @@ asm (
 "	.popsection				\n"
 );
=20
-extern char kernel_headers_data;
+extern char kernel_headers_data[];
 extern char kernel_headers_data_end;
=20
 static ssize_t
@@ -34,7 +34,7 @@ ikheaders_read(struct file *file,  struct kobject *kobj,
 	       struct bin_attribute *bin_attr,
 	       char *buf, loff_t off, size_t len)
 {
-	memcpy(buf, &kernel_headers_data + off, len);
+	memcpy(buf, &kernel_headers_data[off], len);
 	return len;
 }
=20
@@ -49,7 +49,7 @@ static struct bin_attribute kheaders_attr __ro_after_init=
 =3D {
 static int __init ikheaders_init(void)
 {
 	kheaders_attr.size =3D (&kernel_headers_data_end -
-			      &kernel_headers_data);
+			      &kernel_headers_data[0]);
 	return sysfs_create_bin_file(kernel_kobj, &kheaders_attr);
 }
=20
--=20
2.39.2

