Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A61365E82B
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjAEJrz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 04:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjAEJro (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 04:47:44 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173554C737
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 01:47:44 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fc4so88741057ejc.12
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 01:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxGh8mMHMz91AO8quvCFee1+JAN7YWNxuZJ3K904sfY=;
        b=nggz5Jpv3NxEyf5xrOmVL9AaIL4VfmUNEDHTDSdlV2SUYNQgmLeNCKNaX42HEa2lMa
         N7r0o4EygiADefBA8RMh6POviAUX8CA4pEKeH7qy/arZvBswdz0a+uZJgCNo/Ie+cjKK
         E3gsDBborpukPLsxx7Ll9+rVPjWo+TeAROo8lxwb5jINPnh+oOFMJYUsj5Vdw1yv5urd
         Do96v3JTD4kGG8iDilp+S93Yn/bz64bRBJ9dQfCq/zkOk7orRDrMNoGfFAFpGwpctJ6M
         yfa8c0BbSjVA8vvtN/n+bVItyL7phcdVU0oqNcIVf0Ipm60y3A7w+pXoGOaGIqv6J342
         w9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxGh8mMHMz91AO8quvCFee1+JAN7YWNxuZJ3K904sfY=;
        b=YfwTh4e5EQ85vEC+rF6bSUc1OyzB09COfrVS+nWxNkxbvBnE0hu9RoqDLiaUwl8Kf4
         teaTV3Sv7MNgrRKR/fJnZqPM5RFHf6D2ANo9O8ReGX0UtyUUg24uzTxgVMp1aYSIYCuG
         9xGzsJBwTN8jOtrxOVAFQ6YdfmIiu+Aa9fJX1DzJ5+z2tGniUb3X1QmzCBupJCdiaGtX
         CkrbbKw/6aZerqtxWLm3rkZHYV/nmhvB1xVS00TvYXETIjjHDexuZiRwIZJ90uEVn7GJ
         Muc6rtf4FlWNU5cgSG4e33rZmjXSrzJ4XEdFBH0ZU2LPwjciwYUkYBg2WRszXftrISIL
         HCDg==
X-Gm-Message-State: AFqh2kpem2WCZstYLyj0DW7scadAqJlupt2ocx99D+kpZyeSio4yzwbP
        FT8Ih2Jj3COCZ5xMUZG6A1U=
X-Google-Smtp-Source: AMrXdXutQ6t2w9GafOmVV6YhfzXAsuF7EEPvko3utfj/d1cd+bIxwbyzmjfswLoGUgFrE1FLvCBMPA==
X-Received: by 2002:a17:906:5e04:b0:7c0:e803:4ebb with SMTP id n4-20020a1709065e0400b007c0e8034ebbmr42381564eju.70.1672912062432;
        Thu, 05 Jan 2023 01:47:42 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id la26-20020a170907781a00b0084767d40f0dsm16029996ejc.115.2023.01.05.01.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 01:47:41 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 5 Jan 2023 10:47:40 +0100
To:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Victor Laforet <victor.laforet@ip-paris.fr>, bpf@vger.kernel.org
Subject: Re: bpf_probe_read_user EFAULT
Message-ID: <Y7acvJqbBJt4V21+@krava>
References: <346230382.476954.1672152966557.JavaMail.zimbra@ip-paris.fr>
 <Y6sWqgncfvtRHp+b@krava>
 <505155146.488099.1672236042622.JavaMail.zimbra@ip-paris.fr>
 <42d3f4d8-fa8b-5774-0f6b-b12162c24736@meta.com>
 <5692f180-5b78-48e0-b974-b60bd58c0839@Spark>
 <Y7PhWlqdG/TjwT75@krava>
 <1105578275.675049.1672845867568.JavaMail.zimbra@ip-paris.fr>
 <Y7Xyp6sQaAqi8qzw@krava>
 <Y7X3qEOXeimw1JmF@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7X3qEOXeimw1JmF@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 04, 2023 at 11:08:23PM +0100, Jiri Olsa wrote:
> On Wed, Jan 04, 2023 at 10:42:02PM +0100, Jiri Olsa wrote:
> > On Wed, Jan 04, 2023 at 04:24:27PM +0100, Victor Laforet wrote:
> > > Ok thanks. As I understand, tp_btf/+ probes (specifically tp_btf/sched_switch that I need) cannot be sleepable? It is then not possible to read user space memory from the bpf code?
> > 
> > yes, only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable

we actually allow to create tp_btf program with BPF_F_SLEEPABLE flag,
because it's TRACING prog type, but still bpf program can't sleep when
executed in tracepoint context..  so I wonder we should not allow to
load it, Alexei?

jirka


---
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 98a8051ce316..390621d79fbb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16755,10 +16755,14 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
-	if (prog->aux->sleepable && prog->type != BPF_PROG_TYPE_TRACING &&
-	    prog->type != BPF_PROG_TYPE_LSM && prog->type != BPF_PROG_TYPE_KPROBE) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable\n");
-		return -EINVAL;
+	if (prog->aux->sleepable) {
+		if ((prog->type == BPF_PROG_TYPE_TRACING &&
+		     prog->expected_attach_type == BPF_TRACE_RAW_TP) ||
+		    (prog->type != BPF_PROG_TYPE_TRACING &&
+		     prog->type != BPF_PROG_TYPE_LSM && prog->type != BPF_PROG_TYPE_KPROBE)) {
+			verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable\n");
+			return -EINVAL;
+		}
 	}
 
 	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
