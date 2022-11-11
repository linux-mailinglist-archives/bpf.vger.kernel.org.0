Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8B0626215
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiKKTf2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiKKTf1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:35:27 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BF579D09
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:35:25 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id cj8-20020a056a00298800b0056cee8a0cf8so3146393pfb.9
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWUOelBJqPtoAbJt/Sj4XyK+JOK+RUqDVkoizMrVmYs=;
        b=hUhAs5L2sL8rRY3bJ0F2K6cN0sXU6dvZPf2xz2sMuXf+1J/QMBoSrg7257sB7lpE4g
         pEMfy1fI78aTp3h0jD5noYci6vz1azzDf7DP3USR0zlHiImGbh3O+U13916wW+nXduui
         AXxi/hfLy6aj2yemlGboR77mgSQBmu2f9PS0QudbhsxOkQza4ArS4Exrs3axc6iz9wpf
         dzrmXr6RNlkuOuVBkg6HdLYZjwbBYwDIwHoQDCBKMiyP7+JMKAn471On1XEYez0zNFbs
         lwNH/+8Gy4CoRdZb4qszTpZXUpVRsnx8evfsMwmAc+wsvApcS5JlfkYDQZ/W03sAU9e3
         r9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWUOelBJqPtoAbJt/Sj4XyK+JOK+RUqDVkoizMrVmYs=;
        b=emqM4MA5qJgG0EHQQtLDAsFnIXLuPVxv3WK7MsDyBolHWkmz8IihMXgW/Qg0TJFzCh
         NiiAyIurDrNN3pTIfU6z0k9hWt9+tvzvlWfU7oeD7gCCRQGbpEpiud9GvhHJ7510UdMA
         hHOznFvZpZ232FkpeNFrrPvckzuWqA2mNcHAOYahxJeRjtgrwf6HX8Osy5DgeXNWrd4N
         HqQ1gPOIQsmvPkZtgsprPCRPOX+f3pymD3YCkcID4z5ud6XBv7O3BeP8T1yFMza8M2AE
         Wo4oE6EFP74kV7sINivN2zUc+eYG15FMgg5256svqGtRl8L42fVEwT6eUJ5mcGbTWhrz
         2Djw==
X-Gm-Message-State: ANoB5plDnu7tlPwJyB+0fVmQPSAzR+lg+ikkN2nRdFkX6zmJ0zUcvdZ6
        xoFDgjsvSrcmcIZAmVZ84WIsNrI=
X-Google-Smtp-Source: AA0mqf65A2KAgRMcLX6sPxxin6QWwCssns5VUPcQX/WDOzS9jY+CiQUdNCgNKNJhEkHaddyFz6fxO+c=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:244e:b0:56b:fb4f:3d7c with SMTP id
 d14-20020a056a00244e00b0056bfb4f3d7cmr4141848pfj.54.1668195324770; Fri, 11
 Nov 2022 11:35:24 -0800 (PST)
Date:   Fri, 11 Nov 2022 11:35:23 -0800
In-Reply-To: <20221111181242.2101192-1-andrii@kernel.org>
Mime-Version: 1.0
References: <20221111181242.2101192-1-andrii@kernel.org>
Message-ID: <Y26j+4GZs1LivMol@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix veristat's singular
 file-or-prog filter
From:   sdf@google.com
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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

On 11/11, Andrii Nakryiko wrote:
> Fix the bug of filtering out filename too early, before we know the
> program name, if using unified file-or-prog filter (i.e., -f
> <any-glob>). Because we try to filter BPF object file early without
> opening and parsing it, if any_glob (file-or-prog) filter is used we
> have to accept any filename just to get program name, which might match
> any_glob.

> Fixes: 10b1b3f3e56a ("selftests/bpf: consolidate and improve file/prog  
> filtering in veristat")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>   tools/testing/selftests/bpf/veristat.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

> diff --git a/tools/testing/selftests/bpf/veristat.c  
> b/tools/testing/selftests/bpf/veristat.c
> index 9e3811ab4866..f961b49b8ef4 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -367,7 +367,13 @@ static bool should_process_file_prog(const char  
> *filename, const char *prog_name
>   		if (f->any_glob) {
>   			if (glob_matches(filename, f->any_glob))
>   				return true;
> -			if (prog_name && glob_matches(prog_name, f->any_glob))
> +			/* If we don't know program name yet, any_glob filter
> +			 * has to assume that current BPF object file might be
> +			 * relevant; we'll check again later on after opening
> +			 * BPF object file, at which point program name will
> +			 * be known finally.
> +			 */
> +			if (!prog_name || glob_matches(prog_name, f->any_glob))
>   				return true;
>   		} else {
>   			if (f->file_glob && !glob_matches(filename, f->file_glob))
> --
> 2.30.2

