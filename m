Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956F8626213
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiKKTfT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiKKTfS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:35:18 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9BC3E0B6;
        Fri, 11 Nov 2022 11:35:18 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 78so5107625pgb.13;
        Fri, 11 Nov 2022 11:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wa0u9WjMdfrDtoNQdvxz75RgHs0C3nrrN8jlNPdiCpI=;
        b=FXRDGik8x+lnhkLZYjwd4P2vPsErIfLDnuYSpWOWbmZknmalveMDes7PnK/Z/F7fJE
         HYfirBSKQCGMigGXGf1eXgjYMh8jWQAxj8E3W/MpPzPIYDDhyVajloLxc24wDK5tya+9
         o5XphFDEovZnsOS794ScV8AlAdNZqMyh2H+GgtQexiNhc8AHk4q4FkoemaToCcJb4JLb
         baJt4YPww1N3rbkK7HGpmsR68byeho5Ygw8VVHz+8BIyVRdEzg5/PwefotZXT/OIql5/
         IoEloEY/9SM3ABPOQ0AxTwfAsxRRRR0cnyD3Vtq/Y2qgVQtLJaLx/cIHJXmfI849D9At
         yWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa0u9WjMdfrDtoNQdvxz75RgHs0C3nrrN8jlNPdiCpI=;
        b=i8Oc0B5YlCS7QL4Leiebv7MiSdVk+1t7u/bP2lf08IqjSA3SpHvFIbJEWx+vprm9MT
         J+c1wZqwlBMQhKvUDf1xfJe+k1LkzyIX4XvsF9OBjkmDNdo/jnYcqjce4Ow6xwT0vGZs
         JGzYwv6WB2d7hOo0KqS7jMvGGwnbz7HzOrqUbHQ3Mx4f+qkLY+ftG0klLYGmj5ddSFOf
         xO32rhj++AzWmbHSJeKF4h0LMMtmAoHU3JP2LkQdyPRq8OMm8SRmrsP3uKjDAhcnzCrY
         4Smt8nX0UFWyDJP3+1zejW5+cJLQQnHkhQ6WUYH6x5GIIPZkM0juP5mMPWSimca7Eo46
         2Pag==
X-Gm-Message-State: ANoB5pmc8P+PSnPWuJCNqQ8Odf/hzVg9j/KXyzzTcqD3zQAide0+MFDP
        LTs0dhNBeY1pzrOGMLp+we4=
X-Google-Smtp-Source: AA0mqf5MsLtvs30drzro+OqBoU6dDIsuhzqKSFwzpYW98qnc/j8HLsEn8QaOC+NBqJgDUMBMvh+fVg==
X-Received: by 2002:a62:5a07:0:b0:56e:76e2:a375 with SMTP id o7-20020a625a07000000b0056e76e2a375mr4301297pfb.4.1668195317472;
        Fri, 11 Nov 2022 11:35:17 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id z27-20020aa7959b000000b00565cf8c52c8sm1988821pfj.174.2022.11.11.11.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:35:17 -0800 (PST)
Date:   Sat, 12 Nov 2022 01:05:09 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf] bpf: Fix offset calculation error in
 __copy_map_value and zero_map_value
Message-ID: <20221111193509.dmklqyxyy3psvgfc@apollo>
References: <20221111125620.754855-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111125620.754855-1-xukuohai@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 11, 2022 at 06:26:20PM IST, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Function __copy_map_value and zero_map_value miscalculated copy offset,
> resulting in possible copy of unwanted data to user or kernel.
>
> Fix it.
>
> Fixes: cc48755808c6 ("bpf: Add zero_map_value to zero map value with special fields")
> Fixes: 4d7d7f69f4b1 ("bpf: Adapt copy_map_value for multiple offset case")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

I also have a fix here for bpf-next, since this won't apply to it:
https://lore.kernel.org/bpf/20221111193224.876706-4-memxor@gmail.com

I think it'd be best if this one gets applied to bpf and mine to bpf-next, and
any conflicts are resolved when merging both trees (the conflict is trivial),
but I'll leave it up to the maintainers to decide.
