Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9A5157D3F
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2020 15:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgBJORc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Feb 2020 09:17:32 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:41484 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgBJORc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Feb 2020 09:17:32 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1j19sL-0004Uz-9I; Mon, 10 Feb 2020 14:17:25 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1j19sI-0000TK-TU; Mon, 10 Feb 2020 14:17:25 +0000
Subject: Re: [PATCH v3] um: Fix some error handling in uml_vector_user_bpf()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jeff Dike <jdike@addtoit.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alex Dewar <alex.dewar@gmx.co.uk>,
        linux-um@lists.infradead.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200128151000.kx2bwayuuxpuqn6t@kili.mountain>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <cd66b933-c433-3d8a-8457-1de6c0716f49@cambridgegreys.com>
Date:   Mon, 10 Feb 2020 14:17:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128151000.kx2bwayuuxpuqn6t@kili.mountain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 28/01/2020 15:27, Dan Carpenter wrote:
> 1) The uml_vector_user_bpf() returns pointers so it should return NULL
>     instead of false.
> 2) If the "bpf_prog" allocation failed, it would have eventually lead to
>     a crash.  We can't succeed after the error happens so it should just
>     return.
> 
> Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v3: Fix screwed up subject.  Sorry.  Not my most shining hour.
> v2: The first version broke the build.  Shame upon me.
> 
>   arch/um/drivers/vector_user.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> index ddcd917be0af..1403cbadf92b 100644
> --- a/arch/um/drivers/vector_user.c
> +++ b/arch/um/drivers/vector_user.c
> @@ -732,13 +732,14 @@ void *uml_vector_user_bpf(char *filename)
>   
>   	if (stat(filename, &statbuf) < 0) {
>   		printk(KERN_ERR "Error %d reading bpf file", -errno);
> -		return false;
> +		return NULL;
>   	}
>   	bpf_prog = uml_kmalloc(sizeof(struct sock_fprog), UM_GFP_KERNEL);
> -	if (bpf_prog != NULL) {
> -		bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
> -		bpf_prog->filter = NULL;
> -	}
> +	if (bpf_prog == NULL)
> +		return NULL;
> +	bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
> +	bpf_prog->filter = NULL;
> +
>   	ffd = os_open_file(filename, of_read(OPENFLAGS()), 0);
>   	if (ffd < 0) {
>   		printk(KERN_ERR "Error %d opening bpf file", -errno);
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
