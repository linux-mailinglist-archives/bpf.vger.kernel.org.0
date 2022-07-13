Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CFE57403D
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 01:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiGMXw6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 19:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiGMXwz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 19:52:55 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5AF52E4A
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 16:52:54 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id f9-20020a636a09000000b00401b6bc63beso6076486pgc.23
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 16:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2UX/GRvHpBDheTnEzEDYr9v3TdbrLb7lbxNDEoAl7wA=;
        b=EUfoEqKCdMCB0XPptOmZEhVWO/To8bhAOjx1DCQbnpPTARjgpxAnodQZkFMsVmmNqD
         s4wEPM1QCeMHAttNd8FsVvjcEJNNmZc3YP+PTGmdRwspL877gjR1BHE4Pcl27fWaD7WZ
         y9kD4474g3Z9YD7hp6LvhFo6s5lbpvwvBZou3VITHqIv1XVyk0jBNIVO5JjxW7Fy5sV5
         Ia33an6opjr/gxsEdqWbrmyHzj/q7IkzXaPjqRzdVWKULXtyN+r2uD/4saf4yXBz7S3E
         9yC8zhgH9QQTE+H/FKhyiNDDIG8kup6ETQScP2WYjLAqlOUmgogPrjf6S0sdvin17iXg
         9v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2UX/GRvHpBDheTnEzEDYr9v3TdbrLb7lbxNDEoAl7wA=;
        b=ahcFbpOV62J9MtIMBLc0r9+q88YtBASjDtOczwLQjnvXWCbdfoDAwVbo6fDLAZ5sNO
         i/KaQkecTLJQD5x7vllDL0INH+2kxYC7ELlIAc83HWJ0ivBqCSeadcvUP8Pt8pW3eqnm
         8n/T/U6pRZNpz+IyEas/IzxbwLDGd38v4DgRwXQRWa+WLEWyhZixDOJULidw9KwrcE09
         xb865b99PfAcjaStTzJL+O12QeI8pBaiLxJWY/iR5buZS9To9hU/GzumCV/NhQPK7QWL
         Tnb0vNwdSQBv3nCJO4yPRbxU5045VRTc+1049jBmG7Hz2lC9PCAVrPCebkFKNYhR7bYC
         Iqhw==
X-Gm-Message-State: AJIora8ol0+Ndz9URiZPRSpvM+JXy0sXJnzMzvBKuvXdXlHsmVW6drpw
        j3NCtOrP9ePNkGxdu7OoflT8xb8=
X-Google-Smtp-Source: AGRyM1uH3mi9bUL6UBB2//XLjR4P8cokwrrEq0Fq9Q4MTXmyio4Nr/h4Coh5aJ1TH0c0ETINmpsSmEM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:124c:b0:16b:a568:996d with SMTP id
 u12-20020a170903124c00b0016ba568996dmr5465809plh.169.1657756374131; Wed, 13
 Jul 2022 16:52:54 -0700 (PDT)
Date:   Wed, 13 Jul 2022 16:52:52 -0700
In-Reply-To: <20220713222544.2355143-1-indu.bhagat@oracle.com>
Message-Id: <Ys9a1MJ3YcFqxwe4@google.com>
Mime-Version: 1.0
References: <20220713222544.2355143-1-indu.bhagat@oracle.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Update documentation for BTF_KIND_FUNC
From:   sdf@google.com
To:     Indu Bhagat <indu.bhagat@oracle.com>
Cc:     bpf@vger.kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/13, Indu Bhagat wrote:
> The vlen bits in the BTF type of kind BTF_KIND_FUNC are used to convey the
> linkage information for functions.

> Signed-off-by: Indu Bhagat <indu.bhagat@oracle.com>

Reviewed-by: Stanislav Fomichev <sdf@google.com>

Judging by:

static inline u16 btf_func_linkage(const struct btf_type *t)
{
	return BTF_INFO_VLEN(t->info);
}

> ---
>   Documentation/bpf/btf.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index f49aeef62d0c..b3a9d5ac882c 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -369,7 +369,7 @@ No additional type data follow ``btf_type``.
>     * ``name_off``: offset to a valid C identifier
>     * ``info.kind_flag``: 0
>     * ``info.kind``: BTF_KIND_FUNC
> -  * ``info.vlen``: 0
> +  * ``info.vlen``: linkage information (static=0, global=1)
>     * ``type``: a BTF_KIND_FUNC_PROTO type

>   No additional type data follow ``btf_type``.
> --
> 2.31.1

