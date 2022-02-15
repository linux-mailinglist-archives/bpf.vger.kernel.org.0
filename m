Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7EF4B739E
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 17:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbiBOQA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 11:00:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241153AbiBOQAg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 11:00:36 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17026BD8B4
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 08:00:26 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id w7so24402180ioj.5
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 08:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ln466cBvk4n46RRBFGcK7jRh/e4Mb4EMRlH7sHpH99g=;
        b=hnutSG0hDJ1ewTiqgtme6yt+rwlnSXwWDQOzjj0o/q7y4foytSx0XDickL+1spFD0s
         3O7V4WZprBIf70zrDfzh8E7hWI9lV0XtEl3UKFeVIYILgB/VNsf4M4st3Z1mL6H14Wq3
         4Q0Rsd4ne8WfZwPi+tA8/wXVEZC4DAibg66RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ln466cBvk4n46RRBFGcK7jRh/e4Mb4EMRlH7sHpH99g=;
        b=srQVH7ZiyOTq4j73ymXVe83MovL9UbEOEXk98tXW2ilnN6MOJEso0rahsgChHKH4q0
         8OTYXwfI4ZCijmVI0mfP/4XYq9a/tly+aOWWlPPKdCFpARqZwUHxd1zgB/w7Za+uijKJ
         EerTf2INtcDcLOXkuVC0hHLcER4y7y21Wro+Tl3XWwylTu4l/NTYsPP0guw2aT+rL31T
         6pCtMbb9Bq78677k8bBR4TFUpoq8YPno6V7enDGDjlXNQjXbQLGil7CGfYYa5PsmHf2d
         QrXXnoRplZ2cNwN+Su7FNdacf3CznESPJ+8cqWtOmcGnZbfsy5HsaD2paT00zDgNWk4j
         +gwA==
X-Gm-Message-State: AOAM532YLUs5vF86ryriOwWzFeZ6QSdRXM+dZ0cYcQ+WlWB/hSWqR4Qm
        PJGgerQe0XQF2jL7u+OZaAWjFQ==
X-Google-Smtp-Source: ABdhPJz7k+sronBYrPMHRqk6JnA50TFxzBpXnBbIG0e5py5t7XqYLJRCRLlzObWAlEHLi+ZaPYOgZA==
X-Received: by 2002:a05:6638:190a:: with SMTP id p10mr3040258jal.313.1644940825457;
        Tue, 15 Feb 2022 08:00:25 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id z5sm8968088ilu.45.2022.02.15.08.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 08:00:25 -0800 (PST)
Subject: Re: [PATCH v2 4/6] selftests/bpf: Add test for bpf_ima_file_hash()
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, revest@chromium.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220215124042.186506-1-roberto.sassu@huawei.com>
 <20220215124042.186506-5-roberto.sassu@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <794e362d-17c0-a673-bda9-a29614221c37@linuxfoundation.org>
Date:   Tue, 15 Feb 2022 09:00:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220215124042.186506-5-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/15/22 5:40 AM, Roberto Sassu wrote:
> Modify the existing IMA test to call bpf_ima_file_hash() and update the
> expected result accordingly.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   .../selftests/bpf/prog_tests/test_ima.c       | 29 ++++++++++++++++---
>   tools/testing/selftests/bpf/progs/ima.c       | 10 +++++--
>   2 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> index 97d8a6f84f4a..62bf0e830453 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> @@ -13,9 +13,10 @@
>   
>   #include "ima.skel.h"
>   
> -static int run_measured_process(const char *measured_dir, u32 *monitored_pid)
> +static int run_measured_process(const char *measured_dir, u32 *monitored_pid,
> +				bool *use_ima_file_hash)
>   {
> -	int child_pid, child_status;
> +	int err, child_pid, child_status;
>   
>   	child_pid = fork();
>   	if (child_pid == 0) {
> @@ -24,6 +25,21 @@ static int run_measured_process(const char *measured_dir, u32 *monitored_pid)
>   		       NULL);
>   		exit(errno);
>   
> +	} else if (child_pid > 0) {
> +		waitpid(child_pid, &child_status, 0);
> +		err = WEXITSTATUS(child_status);
> +		if (err)
> +			return err;
> +	}
> +
> +	child_pid = fork();
> +	if (child_pid == 0) {
> +		*monitored_pid = getpid();
> +		*use_ima_file_hash = true;
> +		execlp("./ima_setup.sh", "./ima_setup.sh", "run", measured_dir,
> +		       NULL);
> +		exit(errno);
> +
>   	} else if (child_pid > 0) {
>   		waitpid(child_pid, &child_status, 0);
>   		return WEXITSTATUS(child_status);
> @@ -72,12 +88,17 @@ void test_test_ima(void)
>   	if (CHECK(err, "failed to run command", "%s, errno = %d\n", cmd, errno))
>   		goto close_clean;
>   
> -	err = run_measured_process(measured_dir, &skel->bss->monitored_pid);
> +	err = run_measured_process(measured_dir, &skel->bss->monitored_pid,
> +				   &skel->bss->use_ima_file_hash);
>   	if (CHECK(err, "run_measured_process", "err = %d\n", err))
>   		goto close_clean;
>   
>   	err = ring_buffer__consume(ringbuf);
> -	ASSERT_EQ(err, 1, "num_samples_or_err");
> +	/*
> +	 * 1 sample with use_ima_file_hash = false
> +	 * 2 samples with use_ima_file_hash = true (./ima_setup.sh, /bin/true)
> +	 */
> +	ASSERT_EQ(err, 3, "num_samples_or_err");
>   	ASSERT_NEQ(ima_hash_from_bpf, 0, "ima_hash");
>   
>   close_clean:
> diff --git a/tools/testing/selftests/bpf/progs/ima.c b/tools/testing/selftests/bpf/progs/ima.c
> index 96060ff4ffc6..9bb63f96cfc0 100644
> --- a/tools/testing/selftests/bpf/progs/ima.c
> +++ b/tools/testing/selftests/bpf/progs/ima.c
> @@ -18,6 +18,8 @@ struct {
>   
>   char _license[] SEC("license") = "GPL";
>   
> +bool use_ima_file_hash;
> +

This can be statis.

>   SEC("lsm.s/bprm_committed_creds")
>   void BPF_PROG(ima, struct linux_binprm *bprm)
>   {
> @@ -28,8 +30,12 @@ void BPF_PROG(ima, struct linux_binprm *bprm)
>   
>   	pid = bpf_get_current_pid_tgid() >> 32;
>   	if (pid == monitored_pid) {

I also noticed monitored_pid is defined in several bpf. Potentially
could be made static. This isn't introduced in this patch though.

> -		ret = bpf_ima_inode_hash(bprm->file->f_inode, &ima_hash,
> -					 sizeof(ima_hash));
> +		if (!use_ima_file_hash)
> +			ret = bpf_ima_inode_hash(bprm->file->f_inode, &ima_hash,
> +						 sizeof(ima_hash));
> +		else
> +			ret = bpf_ima_file_hash(bprm->file, &ima_hash,
> +						sizeof(ima_hash));
>   		if (ret < 0 || ima_hash == 0)
>   			return;
>   
> 

thanks,
-- Shuah
