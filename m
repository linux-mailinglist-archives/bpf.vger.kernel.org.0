Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E5A6DB534
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 22:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDGUbS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 16:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDGUbR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 16:31:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB3E7A83
        for <bpf@vger.kernel.org>; Fri,  7 Apr 2023 13:31:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j1so3814098wrb.0
        for <bpf@vger.kernel.org>; Fri, 07 Apr 2023 13:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680899474; x=1683491474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qibfGmguJ4UfrBa5vhdJz7TU0Ic3a95y1BNUi4NdCA=;
        b=APQmZXOFWZ5EEcZfHQqOhAvX+iKXBO4pPSDNvV86nkBTQWokDuApno+EbjCQyZ5m8d
         lOi/dw/nVQwCwu35Z2nRs3kq3qbapXE6zgTQvX2t2mD8r5gJvFBOdjck0oMtOQE3Hamf
         b8FWrjeZ0hhZLNt0WmEqaXf9+uLX+ID+HpJhvWHadH4Z85l0rCMfqV+ilHM6MOm3GXvr
         REsEOGcqCloJkgw/VJ3A4HCBJ3+KmJpukKMSqAQE9M+PWrVm/p/ZwOyMfVgodCIF2B12
         GUsThvOttv7bqfLylxOL2Rc9i65jSSeM82HJbWF6KXhG0hhyHHfEk2qwo39HfMGsXrD9
         fwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680899474; x=1683491474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qibfGmguJ4UfrBa5vhdJz7TU0Ic3a95y1BNUi4NdCA=;
        b=32GZojnmEe3KNsWGO8TSMdes3yKVdrdzMyUYLs7d7Q5hmTSe2sHvPqI0/n1zrB3Gk1
         A8/87HVEl1Wd0OQenlMBteayfeAU1UIxIBs8R+Si9QWgCbVbMfs4XAp0YJr3qxpBnYSg
         5NEVJ3pKpU5yBEvQavNYB13zxfloCvWsZpO85XEY/oGqYIOlXJbLZ+t2DbzNBUpTssIp
         smdPBSxgWCYIcNsGFiO1q9xUpZN+hNQWZOufMpY4uz5JsYczzT399CrpH+x6tPNEXMXl
         IYju1MO/vM4iN1jgTMIqu7BDyZVgHYFTO7qmKgXctNtOrrcIE5K0m43vPzZF4fjGctBw
         9yVQ==
X-Gm-Message-State: AAQBX9c5rN8NRpt/y918CIqzJJ2jcOyxCldIgUs279zGAYNQf4gFXGu8
        ynNiWV3oag4gj5pH3igygQaJoLHGtqd5H+JNqkk=
X-Google-Smtp-Source: AKy350ZPXtkQEkwkuCizMe3J18x/9aJksTnPXroCHmzxor1W7GuBjbr592/0Q05TOyYAweLEaXcfZQ==
X-Received: by 2002:adf:e882:0:b0:2e5:87cc:54b3 with SMTP id d2-20020adfe882000000b002e587cc54b3mr2112344wrm.54.1680899474359;
        Fri, 07 Apr 2023 13:31:14 -0700 (PDT)
Received: from krava (cpc137424-wilm3-2-0-cust276.1-4.cable.virginm.net. [82.23.5.21])
        by smtp.gmail.com with ESMTPSA id m3-20020adfdc43000000b002c5691f13eesm5324450wrj.50.2023.04.07.13.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 13:31:13 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 7 Apr 2023 21:31:11 +0100
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] selftests/bpf: Use PERF_COUNT_HW_CPU_CYCLES
 event for get_branch_snapshot
Message-ID: <ZDB9j2G4pTtNDCJc@krava>
References: <20230407190130.2093736-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407190130.2093736-1-song@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 07, 2023 at 12:01:30PM -0700, Song Liu wrote:
> perf_event with type=PERF_TYPE_RAW and config=0x1b00 turned out to be not
> reliable in ensuring LBR is active. Thus, test_progs:get_branch_snapshot is
> not reliable in some systems. Replace it with PERF_COUNT_HW_CPU_CYCLES
> event, which gives more consistent results.
> 
> Signed-off-by: Song Liu <song@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
> index 3948da12a528..0394a1156d99 100644
> --- a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
> +++ b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
> @@ -37,8 +37,8 @@ static int create_perf_events(void)
>  
>  	/* create perf event */
>  	attr.size = sizeof(attr);
> -	attr.type = PERF_TYPE_RAW;
> -	attr.config = 0x1b00;
> +	attr.type = PERF_TYPE_HARDWARE;
> +	attr.config = PERF_COUNT_HW_CPU_CYCLES;
>  	attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
>  	attr.branch_sample_type = PERF_SAMPLE_BRANCH_KERNEL |
>  		PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANCH_ANY;
> -- 
> 2.34.1
> 
