Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0580D5B8EBC
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 20:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiINSP5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 14:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiINSPz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 14:15:55 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54E581695
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 11:15:51 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id f13so7285013qkk.6
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vnzfdOKLIVU+LdB7pkSZ/shmrsmivP69BUtxhc7yWtE=;
        b=PbLrNz1muqGs6C2HXcUX4tKV1A1V2Ij/BZpI5N2It7JtkIv1Bb/kpImcy3pk/XutUf
         90pTyjGz8aibHmEnsqFGLU9MrUm/I5rJBmGNWFa4SJalsWGWljw4jxAJ6NIQEW2CMR1f
         /seGqG7fItGckxJI+pbNkWw20UUEOxsw98as/2B3LiS/s1CR5xGQAFJIxQGH8LWlPbRk
         /31DQKQKRTvSGzkHU68SP0lMsUvWq4MEO7JHPifyW89v2XHqTgoTdj1HLxa3nLMutkZT
         E9ws02CnMpCnSxVFDVjjRLbrHNamxrrgoJGIwc8CyQ5t2OzBo/hA4uoQkrwXtsn9GpK/
         495A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vnzfdOKLIVU+LdB7pkSZ/shmrsmivP69BUtxhc7yWtE=;
        b=NhfJm2wt11SfN7Fz42RGrkDxqXqoj2TVmKEnHiYxXjYElS/BDPwdnAwZ2dvZevFe7s
         TyZo8tjfZxoTCz0beqZVOWE9DI9X+SKTS3+TYU1XSMwlMnKxOloWzwHeOWq7jY/iVinE
         YxYoNeBDdIePXpFTQlfi3/akn+wDAmW0V5vlI/31QSkzuxMya1XfDiLuZ0Rl4nT2JrK2
         A5o3IboMrIeTubZ1DolGOSZooBNcmgQ9OYllaovodtaNY7JZF2fuxgHgjmatQNxnl3ro
         8/J1i1SzF9A/hH14bjY1mVK5XEDTryUN5Z0b34saU+HPURZtIwIixXea/af3aK8HU6at
         H9ag==
X-Gm-Message-State: ACgBeo3LZZkXfYORx6F07W24ywGcCmb4CtcRE+NgYAIb4RrcAbAhY2F/
        z7ZfopI8/+tA8qOAwgAV4wv79xGf7HGS8M99PKlX4iBqejC+hUnx
X-Google-Smtp-Source: AA6agR5pnPIUttp8wDBH3u+vcrj/weO4zNsNtKy4JrxzTt9V3OwxiMKaAWRMskba78pF5IQm+rlDbaozrs4XGoRVLK8=
X-Received: by 2002:a37:63d1:0:b0:6ce:5f67:47bc with SMTP id
 x200-20020a3763d1000000b006ce5f6747bcmr8489977qkb.682.1663179350617; Wed, 14
 Sep 2022 11:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220914123423.24368-1-liuxin350@huawei.com>
In-Reply-To: <20220914123423.24368-1-liuxin350@huawei.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 14 Sep 2022 11:15:39 -0700
Message-ID: <CA+khW7hS=c4PSo4coBmw+6VReWNhj+4Bnsr+r+mGsG4tCZ8KnQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: adjust OPTS_VALID logic, so that it can be used correctly
To:     Xin Liu <liuxin350@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com, zhudi2@huawei.com,
        kongweibin2@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Xin,

On Wed, Sep 14, 2022 at 5:35 AM Xin Liu <liuxin350@huawei.com> wrote:
>
> We found that function btf_dump__dump_type_data can be called by the user
> as an api, but in this function, the `opts` parameter may be used as a
> null pointer, because OPTS_VALID can't properly prevent opts used as null
> pointers during verification. Therefore, we fix this problem through this
> modification.
>
> This modification has no impact on other places where OPTS_VALID has been
> used.

I think this is a bug of btf_dump__dump_type_data(), not OPTS_VALID.
It seems allowing OPTS_VALID to accept NULL is the intended behavior.

>
[...]
>
