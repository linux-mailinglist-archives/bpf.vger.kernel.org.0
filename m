Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79CD6974A4
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 04:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBODDA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 22:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBODC7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 22:02:59 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825BCBBBB
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 19:02:55 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x2-20020a056a000bc200b005a8ea29c7a6so1196022pfu.15
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 19:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vhvQUMjoFdnxKd1vKGkHiHtnmrXNJNR7pmkqsAc+VZA=;
        b=mxuyaXv9ndCjDF/QtupmeLvBQMItQIrveMbHhSZOYDC7JFSv4cqYyWOmj/GjAFVGNu
         djarZtu8xaoKZpHMls8UEg5Bh5wToD/j4ZDB/IriUGB80Bt+DM27j3g1JsOURBbdvBYB
         q0j3yHavQp2qU0maESpPSM5uSncRVXswxUvB4Tec6N7lC/23OobaZfqmKbQf56u5SJ0B
         RMsDVO30isQi8fvP0aTOPYwpEc0FBHrVSLFlnxRtzLsfiSpgdma618UGGec6QA/cHw1b
         k0x95HUeFZdwMcesTpEEbM/bprStDB+qxM0FsPN4Kjt86rmWJgIX8ImFzj5zm2tVU4po
         Gp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhvQUMjoFdnxKd1vKGkHiHtnmrXNJNR7pmkqsAc+VZA=;
        b=KilcXNI8VtQWT2mx1fX9yCHx4nEXBDNeeGUDpLPV+V54wgYC45HKh22jg4aPMSy3md
         dhoffdfq+gf/Q6/8rWA8JtR/FI/qsh8ke1So3mjoaAmnRYHVpjknvcnpCkhiLy7k83U6
         VmxcTtLevrlK8wvBoeqzB6+MvRbWpGTKNNmnRlC2/j3r09nc+0feaknpdgtuMpK2BAAH
         YNLQwMu/kHhcDYk6/kr5B2DdxStQdtGBLo2EiVAdXWPMwD6anp/qxGKykaF5TaSO/0dJ
         JueFnLV3TYVvI+eLPcVjhuEKzDH5JKyYO8OB863Yj9+SGW5K0V13fQnERU4Kk/ycvNp0
         NXvg==
X-Gm-Message-State: AO0yUKUpd55W7E3kneju4s3uyCSEtuQL3BPCzLpu1nEgTqV2pynvnpUM
        t99U4BnPOFhsWkHJ90LC87uSV7c=
X-Google-Smtp-Source: AK7set+lgb3/ms+zvD0TVDWNUoClknXzolWi8DrLG/mlVpVSqOltH3K6qOYxY62fnzhpAD24nHl/nRw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:af59:0:b0:4fb:ee04:732a with SMTP id
 s25-20020a63af59000000b004fbee04732amr101573pgo.2.1676430174968; Tue, 14 Feb
 2023 19:02:54 -0800 (PST)
Date:   Tue, 14 Feb 2023 19:02:53 -0800
In-Reply-To: <20230214235051.22938-1-alexei.starovoitov@gmail.com>
Mime-Version: 1.0
References: <20230214235051.22938-1-alexei.starovoitov@gmail.com>
Message-ID: <Y+xLXcmf1pxl43dn@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix map_kptr test.
From:   Stanislav Fomichev <sdf@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, memxor@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/14, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>

> The compiler is optimizing out majority of unref_ptr read/writes, so the  
> test
> wasn't testing much. For example, one could delete '__kptr' tag from
> 'struct prog_test_ref_kfunc __kptr *unref_ptr;' and the test would  
> still "pass".

> Convert it to volatile stores. Confirmed by comparing bpf asm  
> before/after.

> Fixes: 2cbc469a6fc3 ("selftests/bpf: Add C tests for kptr")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>   tools/testing/selftests/bpf/progs/map_kptr.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

> diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c  
> b/tools/testing/selftests/bpf/progs/map_kptr.c
> index eb8217803493..228ec45365a8 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr.c
> @@ -62,21 +62,23 @@ extern struct prog_test_ref_kfunc *
>   bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int  
> b) __ksym;
>   extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)  
> __ksym;


[..]

> +#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) = (val))

(thinking out loud)

Maybe time for us to put these into some common headers in the
selftests.
progs/test_ksyms_btf_null_check.c READ_ONCE as well..

> +
>   static void test_kptr_unref(struct map_value *v)
>   {
>   	struct prog_test_ref_kfunc *p;

>   	p = v->unref_ptr;
>   	/* store untrusted_ptr_or_null_ */
> -	v->unref_ptr = p;
> +	WRITE_ONCE(v->unref_ptr, p);
>   	if (!p)
>   		return;
>   	if (p->a + p->b > 100)
>   		return;
>   	/* store untrusted_ptr_ */
> -	v->unref_ptr = p;
> +	WRITE_ONCE(v->unref_ptr, p);
>   	/* store NULL */
> -	v->unref_ptr = NULL;
> +	WRITE_ONCE(v->unref_ptr, NULL);
>   }

>   static void test_kptr_ref(struct map_value *v)
> @@ -85,7 +87,7 @@ static void test_kptr_ref(struct map_value *v)

>   	p = v->ref_ptr;
>   	/* store ptr_or_null_ */
> -	v->unref_ptr = p;
> +	WRITE_ONCE(v->unref_ptr, p);
>   	if (!p)
>   		return;
>   	if (p->a + p->b > 100)
> @@ -99,7 +101,7 @@ static void test_kptr_ref(struct map_value *v)
>   		return;
>   	}
>   	/* store ptr_ */
> -	v->unref_ptr = p;
> +	WRITE_ONCE(v->unref_ptr, p);
>   	bpf_kfunc_call_test_release(p);

>   	p = bpf_kfunc_call_test_acquire(&(unsigned long){0});
> --
> 2.30.2

