Return-Path: <bpf+bounces-8622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 006B2788BFD
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A002281779
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39601101D7;
	Fri, 25 Aug 2023 14:57:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C2CA60
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 14:57:38 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B6B1FCB
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=nMQ9oTK9VIity3mYsTzxf6sAs815oCB1cNM2hcEx14c=; b=nL77Lw4X3E8ie2ogC6+xtQZ/t0
	9x9dvUBUb1TGigRAkEhDh4p114nMp13t617sIDCkV7xDOgcO26S8rLwpQt+j4d7CUei/7VN/pEqIg
	2j13yUM5Fiy9ypC5D7lQZ628XKYkYb74k2fByHQm9X2OuBSuozNvmf3vEDxf5JcVTXuKambgNQtyV
	R/LLHPETnB7VYIBDXyFO16Y+t+bapCsgTC9KzvuYVEDXtMOszj4ybsQkIfS4gqp3aEAjhqrwIXyI3
	Zwyi5owBpEwMnsdsgxQp0mZGuGlO18xjvT6iWDEe/nnE2uDVkvRiL1XEGSsco3Im9DZtKPAuF7FEM
	27DC1IQg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qZYFj-000MrV-9T; Fri, 25 Aug 2023 16:57:35 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qZYFj-000Wnn-DL; Fri, 25 Aug 2023 16:57:35 +0200
Subject: Re: [PATCH bpf 3/3] samples/bpf: syscall_tp_user: Fix array
 out-of-bound access
To: Jinghao Jia <jinghao@linux.ibm.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
References: <20230818164643.97782-1-jinghao@linux.ibm.com>
 <20230818164643.97782-4-jinghao@linux.ibm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6eeaead1-ed88-eb60-a134-0777d9ac0851@iogearbox.net>
Date: Fri, 25 Aug 2023 16:57:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230818164643.97782-4-jinghao@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27011/Fri Aug 25 09:40:47 2023)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/18/23 6:46 PM, Jinghao Jia wrote:
> Commit 06744f24696e ("samples/bpf: Add openat2() enter/exit tracepoint
> to syscall_tp sample") added two more eBPF programs to support the
> openat2() syscall. However, it did not increase the size of the array
> that holds the corresponding bpf_links. This leads to an out-of-bound
> access on that array in the bpf_object__for_each_program loop and could
> corrupt other variables on the stack. On our testing QEMU, it corrupts
> the map1_fds array and causes the sample to fail:
> 
>    # ./syscall_tp
>    prog #0: map ids 4 5
>    verify map:4 val: 5
>    map_lookup failed: Bad file descriptor
> 
> Dynamically allocate the array based on the number of programs reported
> by libbpf to prevent similar inconsistencies in the future
> 
> Fixes: 06744f24696e ("samples/bpf: Add openat2() enter/exit tracepoint to syscall_tp sample")
> Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
> ---
>   samples/bpf/syscall_tp_user.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/samples/bpf/syscall_tp_user.c b/samples/bpf/syscall_tp_user.c
> index 18c94c7e8a40..8855d2c1290d 100644
> --- a/samples/bpf/syscall_tp_user.c
> +++ b/samples/bpf/syscall_tp_user.c
> @@ -48,7 +48,7 @@ static void verify_map(int map_id)
>   static int test(char *filename, int nr_tests)
>   {
>   	int map0_fds[nr_tests], map1_fds[nr_tests], fd, i, j = 0;
> -	struct bpf_link *links[nr_tests * 4];
> +	struct bpf_link **links = NULL;
>   	struct bpf_object *objs[nr_tests];
>   	struct bpf_program *prog;
>   
> @@ -60,6 +60,17 @@ static int test(char *filename, int nr_tests)
>   			goto cleanup;
>   		}
>   
> +		/* One-time initialization */
> +		if (!links) {
> +			int nr_progs = 0;
> +
> +			bpf_object__for_each_program(prog, objs[i])
> +				nr_progs += 1;
> +
> +			links = calloc(nr_progs * nr_tests,
> +				       sizeof(struct bpf_link *));

NULL check is missing

> +		}
> +
>   		/* load BPF program */
>   		if (bpf_object__load(objs[i])) {
>   			fprintf(stderr, "loading BPF object file failed\n");
> @@ -107,8 +118,13 @@ static int test(char *filename, int nr_tests)
>   	}
>   
>   cleanup:
> -	for (j--; j >= 0; j--)
> -		bpf_link__destroy(links[j]);
> +	if (links) {
> +		for (j--; j >= 0; j--)
> +			bpf_link__destroy(links[j]);
> +
> +		free(links);
> +		links = NULL;

why is this explicit links = NULL needed?

> +	}
>   
>   	for (i--; i >= 0; i--)
>   		bpf_object__close(objs[i]);
> 


