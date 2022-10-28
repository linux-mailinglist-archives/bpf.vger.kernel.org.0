Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45C9611E12
	for <lists+bpf@lfdr.de>; Sat, 29 Oct 2022 01:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJ1XYg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 19:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ1XYe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 19:24:34 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92EC1A39E
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 16:24:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so8677525pjh.1
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 16:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvJTRiJEqHAzLBn1Q67HdapERY1Efp+/IyfhvO5bHXg=;
        b=ODiVpjXBtJXZxzV5zIFoTZuCnj2RUcmdlAX/J2bS6L4tswJmuY2p+bXIVtAe+4XsBh
         hOFH3GeWvcOIFzvILUClO3QdjQa6Ix5/1Wqvvsuggaf4LO5RwTaJjSzYAh8MJ7nlAqdy
         ZKXqYLvR1TClX5FQQRSB/d3sOfi4bqK1QLNgniV46BtpcJIgzyRaHiZP/l6Kouarj3AS
         uX0Ir8qWvLiM5iToxwc8LA9CGwEw4esY6QpAq1ZFV9/14+ZYEVXmVSI5k/w4Kfcg93kv
         eylef/A1nAWHkQqpZv9ms4dejzjGva27YoKMqa/jKbCSqNiJhCh5QhfEeUUj3PDTu0vH
         BxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvJTRiJEqHAzLBn1Q67HdapERY1Efp+/IyfhvO5bHXg=;
        b=Uz/X8P/yfEvDxkmjKe5JLtOCp1Y4SHubyPSBCIcOYSUfEm088mMqV/IjczkmAvmiUO
         BezwlqkzVHCzd3oWZMGE/DLFh56pFuJ0jbx3fnfmpF8GXEo855u2TSKguDplV2LRr7n4
         e6cd+PyU3tQnx2jOA0bYbhE3mWbskQjNGNXMzsYKKb7ob9+ldTzni61E88BQ2mvCYrrx
         uml3YiTVTxwrJABj4WltKJpV11uOCSICDqDh7+U2cgGF7nJNPPoBW4lCp8MBnjb3QCwE
         ZzWNRFWycVoQM/I25E0ZsuShUsyyO3aErCPYlS/In3XTW2nPztdDXi87S92pAZHdhf7Q
         zMsg==
X-Gm-Message-State: ACrzQf2KMf5GBq09xQYhT80n6CqNj0EK4km/F+wSFqMtchzQaK/3UhMO
        mZA2U2WD8RQt4IER9eo5uUc=
X-Google-Smtp-Source: AMsMyM53jKsHOvLK2C7o5kweGmFC23Qxqyyrar9IG/3yiDxX3zxwa/WPw4L2QQlzVJij2aIukJ3ECg==
X-Received: by 2002:a17:90b:11d4:b0:212:ee83:481 with SMTP id gv20-20020a17090b11d400b00212ee830481mr1777538pjb.36.1666999471326;
        Fri, 28 Oct 2022 16:24:31 -0700 (PDT)
Received: from localhost ([98.97.41.13])
        by smtp.gmail.com with ESMTPSA id q4-20020aa79824000000b0056bb7d90f0fsm3345430pfl.182.2022.10.28.16.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 16:24:30 -0700 (PDT)
Date:   Fri, 28 Oct 2022 16:24:27 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
Message-ID: <635c64abe004c_b1ba20850@john.notmuch>
In-Reply-To: <20221028175530.1413351-1-cerasuolodomenico@gmail.com>
References: <20221028175530.1413351-1-cerasuolodomenico@gmail.com>
Subject: RE: [PATCH bpf-next] selftests: fix test group SKIPPED result
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Domenico Cerasuolo wrote:
> From: Domenico Cerasuolo <dceras@meta.com>
> 
> When showing the result of a test group, if one
> of the subtests was skipped, while still having
> passing subtets, the group result was marked as
> SKIPPED.
> 
> #223/1   usdt/basic:SKIP
> #223/2   usdt/multispec:OK
> #223     usdt:SKIP
> 
> With this change only if all of the subtests
> were skipped the group test is marked as SKIPPED.
> 
> #223/1   usdt/basic:SKIP
> #223/2   usdt/multispec:OK
> #223     usdt:OK

I'm not sure don't you want to know that some of the tests
were skipped? With this change its not knowable from output
if everything passed or one passed.

I would prefer the behavior: If anything fails return
FAIL, else if anything is skipped SKIP and if _everything_
passes mark it OK.

My preference is to drop this change.

> 
> Signed-off-by: Domenico Cerasuolo <dceras@meta.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 0e9a47f97890..14b70393018b 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -222,6 +222,11 @@ static char *test_result(bool failed, bool skipped)
>  	return failed ? "FAIL" : (skipped ? "SKIP" : "OK");
>  }
>  
> +static char *test_group_result(int tests_count, bool failed, int skipped)
> +{
> +	return failed ? "FAIL" : (skipped == tests_count ? "SKIP" : "OK");
> +}
> +
>  static void print_test_log(char *log_buf, size_t log_cnt)
>  {
>  	log_buf[log_cnt] = '\0';
> @@ -308,7 +313,8 @@ static void dump_test_log(const struct prog_test_def *test,
>  	}
>  
>  	print_test_name(test->test_num, test->test_name,
> -			test_result(test_failed, test_state->skip_cnt));
> +			test_group_result(test_state->subtest_num,
> +				test_failed, test_state->skip_cnt));
>  }
>  
>  static void stdio_restore(void);
> @@ -1071,7 +1077,8 @@ static void run_one_test(int test_num)
>  
>  	if (verbose() && env.worker_id == -1)
>  		print_test_name(test_num + 1, test->test_name,
> -				test_result(state->error_cnt, state->skip_cnt));
> +				test_group_result(state->subtest_num,
> +					state->error_cnt, state->skip_cnt));
>  
>  	reset_affinity();
>  	restore_netns();
> -- 
> 2.30.2
> 


