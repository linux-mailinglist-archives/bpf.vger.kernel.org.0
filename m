Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454C14B720A
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 17:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbiBOQLp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 11:11:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbiBOQLW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 11:11:22 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC55CEA08
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 08:11:07 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id m185so24415542iof.10
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 08:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uya3VrJ5mbeW5e3EiyZomdfwW6pYC+/8k7L0vXEy/64=;
        b=GqhrTd29C1Fa/GF7XdeyaZQ3hqUrBB2h17CHBFffHv2hxDx4zjmbEz0vOyg0Iq6R4M
         2H7TFNA3sVqU8hkGQKByqZzQE7IH19x0/irG56NJvKU+wpiHH9Dv0RwN43FfYB3shghc
         QMqwnn6TGVnovhyQd07APJlJB7dev7UiXwUtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uya3VrJ5mbeW5e3EiyZomdfwW6pYC+/8k7L0vXEy/64=;
        b=NyQpm7WRH/RRIu6C0RqhBw2l1mcaigANVEwdwsk8dLKr1ShVAfVF1m2r5RluPUGIv6
         ZRtymIKGMeySjPZOkPDH5Y13y55CYH5z8SIYosEFQJwds5xXs39Vq6cCfom+gZI8bb6q
         feNfaRKEdz2kS7K9gS8fXPP24lRclhLoW+fmTAHqw5NLZ8ehVApZaMtvrtLT1/mEcZct
         ZNMY6vYNlPncyewon6PmXBxzTek7uX/Bp8l13qlEmC4NVoKc9QIaq0PlfYn8vAQ6WhgK
         8soBwb43yZo48DO8uh7oFNXaAmeUhLRAFsrcntzFT50ThJwDha5yV9pLcxwx+i/Q1iCE
         UWrA==
X-Gm-Message-State: AOAM533tBAGR9SfBHk5HMuh5ko7COC4Ywc+fpgwlO5ku+D6SvdQzjBq9
        WnLn8QvbExgrRygp15SAJEtafQ==
X-Google-Smtp-Source: ABdhPJwNMQ+hD4yYnX67fbKxMkuWIh4ikYUTO3MVI4i6Lb6x2R7QnWChrXVehVMDRoy3LOMo6wasHA==
X-Received: by 2002:a05:6638:6bb:: with SMTP id d27mr3009674jad.231.1644941467203;
        Tue, 15 Feb 2022 08:11:07 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l2sm5384520ilv.66.2022.02.15.08.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 08:11:06 -0800 (PST)
Subject: Re: [PATCH v2 6/6] selftests/bpf: Add test for
 bpf_lsm_kernel_read_file()
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, revest@chromium.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220215124042.186506-1-roberto.sassu@huawei.com>
 <20220215124042.186506-7-roberto.sassu@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a06aaff2-2760-faff-db00-082543953bfe@linuxfoundation.org>
Date:   Tue, 15 Feb 2022 09:11:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220215124042.186506-7-roberto.sassu@huawei.com>
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
> Test the ability of bpf_lsm_kernel_read_file() to call the sleepable
> functions bpf_ima_inode_hash() or bpf_ima_file_hash() to obtain a
> measurement of a loaded IMA policy.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   tools/testing/selftests/bpf/ima_setup.sh      |  2 ++
>   .../selftests/bpf/prog_tests/test_ima.c       |  3 +-
>   tools/testing/selftests/bpf/progs/ima.c       | 28 ++++++++++++++++---
>   3 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> index 8e62581113a3..82530f19f85a 100755
> --- a/tools/testing/selftests/bpf/ima_setup.sh
> +++ b/tools/testing/selftests/bpf/ima_setup.sh
> @@ -51,6 +51,7 @@ setup()
>   
>   	ensure_mount_securityfs
>   	echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
> +	echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${mount_dir}/policy_test
>   }
>   
>   cleanup() {
> @@ -74,6 +75,7 @@ run()
>   	local mount_dir="${tmp_dir}/mnt"
>   	local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
>   
> +	echo ${mount_dir}/policy_test > ${IMA_POLICY_FILE}
>   	exec "${copied_bin_path}"
>   }
>   
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> index 62bf0e830453..c4a62d7b70df 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> @@ -97,8 +97,9 @@ void test_test_ima(void)
>   	/*
>   	 * 1 sample with use_ima_file_hash = false
>   	 * 2 samples with use_ima_file_hash = true (./ima_setup.sh, /bin/true)
> +	 * 1 sample with use_ima_file_hash = true (IMA policy)
>   	 */
> -	ASSERT_EQ(err, 3, "num_samples_or_err");
> +	ASSERT_EQ(err, 4, "num_samples_or_err");
>   	ASSERT_NEQ(ima_hash_from_bpf, 0, "ima_hash");
>   
>   close_clean:
> diff --git a/tools/testing/selftests/bpf/progs/ima.c b/tools/testing/selftests/bpf/progs/ima.c
> index 9bb63f96cfc0..9b4c03f30a1c 100644
> --- a/tools/testing/selftests/bpf/progs/ima.c
> +++ b/tools/testing/selftests/bpf/progs/ima.c
> @@ -20,8 +20,7 @@ char _license[] SEC("license") = "GPL";
>   
>   bool use_ima_file_hash;
>   
> -SEC("lsm.s/bprm_committed_creds")
> -void BPF_PROG(ima, struct linux_binprm *bprm)
> +static void ima_test_common(struct file *file)
>   {
>   	u64 ima_hash = 0;
>   	u64 *sample;
> @@ -31,10 +30,10 @@ void BPF_PROG(ima, struct linux_binprm *bprm)
>   	pid = bpf_get_current_pid_tgid() >> 32;
>   	if (pid == monitored_pid) {
>   		if (!use_ima_file_hash)
> -			ret = bpf_ima_inode_hash(bprm->file->f_inode, &ima_hash,
> +			ret = bpf_ima_inode_hash(file->f_inode, &ima_hash,
>   						 sizeof(ima_hash));
>   		else
> -			ret = bpf_ima_file_hash(bprm->file, &ima_hash,
> +			ret = bpf_ima_file_hash(file, &ima_hash,
>   						sizeof(ima_hash));
>   		if (ret < 0 || ima_hash == 0)

Is this considered an error? Does it make sense for this test to be
void type and not return the error to its callers? One of the callers
below seems to care for return values.

>   			return;
> @@ -49,3 +48,24 @@ void BPF_PROG(ima, struct linux_binprm *bprm)
>   
>   	return;
>   }
> +
> +SEC("lsm.s/bprm_committed_creds")
> +void BPF_PROG(ima, struct linux_binprm *bprm)
> +{
> +	ima_test_common(bprm->file);
> +}
> +
> +SEC("lsm.s/kernel_read_file")
> +int BPF_PROG(kernel_read_file, struct file *file, enum kernel_read_file_id id,
> +	     bool contents)
> +{
> +	if (!contents)
> +		return 0;
> +
> +	if (id != READING_POLICY)
> +		return 0;
> +
> +	ima_test_common(file);

This one here.

> +
> +	return 0;
> +}
> 

thanks,
-- Shuah
