Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5088D6784F6
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 19:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjAWSdL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 13:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAWSdK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 13:33:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC6A2130;
        Mon, 23 Jan 2023 10:33:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso11820908pjf.1;
        Mon, 23 Jan 2023 10:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZyQd+AYN2juYO0X6HbN3MV4SJsXkVq+MSMeqnC4KyQ=;
        b=nIcP9FH4Bnj7RI1miGpxw3TV3VFIW+ZhVTfMuz/oc7xyuqirtUqB6nJCtWxdH8WYD0
         ToB3m314IOwrj0uEFs0veIXoIPGVFrAzmEvUfaKl9ThJXisRM3RDI+/PjWLYQ1wzgPPC
         L2nYYgDhv4aNnZdIdFzYXa/sECxRJ770Y2HOtWUdyyWELVC5rpcqQFQhbEUNaSKzUdKW
         YXqVWbEPbWc39HEyjKX1tdvLivkvaOkmihCJ4N0ofZpdmwVmHeTp+9JCBUlWp5u/Tlhp
         2XEskgRYGo2lryOGIlvpKeCxFfypyR6O17MGB/SbV1Dx3GJIsyywozhKK6CyTZ+QacBx
         BNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZyQd+AYN2juYO0X6HbN3MV4SJsXkVq+MSMeqnC4KyQ=;
        b=4RFzuOtPpltzrN1l9n7FKVedZxPhkLDUa/NXroBexqIMR8KTpMzCVNa87MZJuaSv/u
         P1P+D17s8d5Wx86m8zB3HohrJiqSZ9Om1RSX9feIVNQOhmStdaGkYe2K3/JdrY8R5J/J
         JBlyACI0HmiiT6snGnaoSm+YXj7Jdu7cMax6Q2ShcghGqSO84tgvyR2cpSh0Zje+UqZN
         AehX2ewK3uQ4ZQl5PUP0qs+5OlUe/bQuCzvAmVoCVy9Gz7CM89h3IqCml3eesH8288Id
         KDvRp36OxuaN1soyWJ1433kTSnVv5m12eL1hzCCrGQjxFIwru7Ffxfz9tzIpTT6Noqix
         OTeQ==
X-Gm-Message-State: AFqh2kp2TXaDOuERm2KiFesxWZJSyEIXs0BFDlm3ZygGAVrM5Tk6O6MA
        GH0l+7WsLjItZAId9DdxSLMW8M/FXT8=
X-Google-Smtp-Source: AMrXdXth1IBdB6Bg3Hd4DvWLygGaxhM/7lhyMDO+R7uE/7sjEMLa6decEMe0tDVzJpB/jVcaN02G0A==
X-Received: by 2002:a17:902:c3cd:b0:193:3154:5c86 with SMTP id j13-20020a170902c3cd00b0019331545c86mr28854554plj.21.1674498789013;
        Mon, 23 Jan 2023 10:33:09 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:500::5:458c])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902d2cf00b00194bea457e7sm10452264plc.292.2023.01.23.10.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 10:33:08 -0800 (PST)
Date:   Mon, 23 Jan 2023 10:33:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        memxor@gmail.com
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc
 definitions
Message-ID: <20230123183305.2mgoxgw4ca3sfk24@macbook-pro-6.dhcp.thefacebook.com>
References: <20230123171506.71995-1-void@manifault.com>
 <20230123171506.71995-4-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123171506.71995-4-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 23, 2023 at 11:15:06AM -0600, David Vernet wrote:
> -void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
> +BPF_KFUNC(void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign))
>  {
>  	struct btf_struct_meta *meta = meta__ign;
>  	u64 size = local_type_id__k;
> @@ -1790,7 +1786,7 @@ void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>  	return p;
>  }
>  
> -void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
> +BPF_KFUNC(void bpf_obj_drop_impl(void *p__alloc, void *meta__ign))
>  {

The following also works:
-BPF_KFUNC(void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign))
+BPF_KFUNC(
+void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
+)

and it looks little bit cleaner to me.

git grep -A1 BPF_KFUNC
can still find all instances of kfuncs.

wdyt?
