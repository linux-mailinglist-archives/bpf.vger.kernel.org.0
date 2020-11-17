Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC8D2B71CD
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 23:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgKQWrn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 17:47:43 -0500
Received: from www62.your-server.de ([213.133.104.62]:60098 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgKQWrn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 17:47:43 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kf9lF-00070i-5Z; Tue, 17 Nov 2020 23:47:41 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kf9lE-000Muh-Ve; Tue, 17 Nov 2020 23:47:41 +0100
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Add tests for bpf_lsm_set_bprm_opts
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Pauline Middelink <middelin@google.com>
References: <20201117021307.1846300-1-kpsingh@chromium.org>
 <20201117021307.1846300-2-kpsingh@chromium.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <edfe92b9-c97e-b36c-eee1-0fe099d2b596@iogearbox.net>
Date:   Tue, 17 Nov 2020 23:47:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201117021307.1846300-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25991/Tue Nov 17 14:12:35 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/17/20 3:13 AM, KP Singh wrote:
[...]
> +
> +static int run_set_secureexec(int map_fd, int secureexec)
> +{
> +

^ same here

> +	int child_pid, child_status, ret, null_fd;
> +
> +	child_pid = fork();
> +	if (child_pid == 0) {
> +		null_fd = open("/dev/null", O_WRONLY);
> +		if (null_fd == -1)
> +			exit(errno);
> +		dup2(null_fd, STDOUT_FILENO);
> +		dup2(null_fd, STDERR_FILENO);
> +		close(null_fd);
> +
> +		/* Ensure that all executions from hereon are
> +		 * secure by setting a local storage which is read by
> +		 * the bprm_creds_for_exec hook and sets bprm->secureexec.
> +		 */
> +		ret = update_storage(map_fd, secureexec);
> +		if (ret)
> +			exit(ret);
> +
> +		/* If the binary is executed with securexec=1, the dynamic
> +		 * loader ingores and unsets certain variables like LD_PRELOAD,
> +		 * TMPDIR etc. TMPDIR is used here to simplify the example, as
> +		 * LD_PRELOAD requires a real .so file.
> +		 *
> +		 * If the value of TMPDIR is set, the bash command returns 10
> +		 * and if the value is unset, it returns 20.
> +		 */
> +		execle("/bin/bash", "bash", "-c",
> +		       "[[ -z \"${TMPDIR}\" ]] || exit 10 && exit 20", NULL,
> +		       bash_envp);
> +		exit(errno);
> +	} else if (child_pid > 0) {
> +		waitpid(child_pid, &child_status, 0);
> +		ret = WEXITSTATUS(child_status);
> +
> +		/* If a secureexec occured, the exit status should be 20.
> +		 */
> +		if (secureexec && ret == 20)
> +			return 0;
> +
> +		/* If normal execution happened the exit code should be 10.
> +		 */
> +		if (!secureexec && ret == 10)
> +			return 0;
> +

and here (rest looks good to me)

> +	}
> +
> +	return -EINVAL;
> +}
> +
