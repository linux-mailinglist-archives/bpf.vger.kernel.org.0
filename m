Return-Path: <bpf+bounces-12942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEAF7D2323
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 15:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6035A1C20988
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 13:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C59DF78;
	Sun, 22 Oct 2023 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G+Gbfdlc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C829AF;
	Sun, 22 Oct 2023 13:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41CBC433C8;
	Sun, 22 Oct 2023 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697980205;
	bh=D2t2WHHQ6QvNidPip0DvrhGkZi1h8KDMHEv9Pkm7Saw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+GbfdlcIyKcuN8fPRXxW6jA7cJNFL1E4IJWG76kIC6pFnQurTcFwR3sy/oMTvGYE
	 aoBopuHwqObWqTVKhcValK0EsmcDDY2/6K9sYmaXxJ8CM5DgA4jCXg0+LgyAS5v7po
	 P+L5f7LhE4WGV54d/d6oforY6cv1u89D1njOB/Uk=
Date: Sun, 22 Oct 2023 15:10:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: James Tirta Halim <tirtajames45@gmail.com>
Cc: linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] strstarts: avoid calling strlen() if first char does not
 match
Message-ID: <2023102217-squeegee-hacking-d43f@gregkh>
References: <20231022113547.168081-1-tirtajames45@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022113547.168081-1-tirtajames45@gmail.com>

On Sun, Oct 22, 2023 at 06:35:47PM +0700, James Tirta Halim wrote:
> ---
>  include/linux/string.h  | 9 ++++++---
>  tools/bpf/bpftool/gen.c | 2 +-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index dbfc66400050..1c51039604e7 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -214,7 +214,7 @@ int ptr_to_hashval(const void *ptr, unsigned long *hashval_out);
>   */
>  static inline bool strstarts(const char *str, const char *prefix)
>  {
> -	return strncmp(str, prefix, strlen(prefix)) == 0;
> +	return (*str == *prefix) ? strncmp(str, prefix, strlen(prefix)) == 0 : (*prefix == '\0');
>  }
>  
>  size_t memweight(const void *ptr, size_t bytes);
> @@ -356,8 +356,11 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
>   */
>  static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
>  {
> -	size_t len = strlen(prefix);
> -	return strncmp(str, prefix, len) == 0 ? len : 0;
> +	if (*str == *prefix) {
> +		size_t len = strlen(prefix);
> +		return strncmp(str, prefix, len) == 0 ? len : 0;
> +	}
> +	return *prefix == '\0';
>  }
>  
>  #endif /* _LINUX_STRING_H_ */
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 2883660d6b67..5f8db7e517bc 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -36,7 +36,7 @@ static void sanitize_identifier(char *name)
>  
>  static bool str_has_prefix(const char *str, const char *prefix)
>  {
> -	return strncmp(str, prefix, strlen(prefix)) == 0;
> +	return (*str == *prefix) ? strncmp(str, prefix, strlen(prefix)) == 0 : (*prefix == '\0');
>  }
>  
>  static bool str_has_suffix(const char *str, const char *suffix)
> -- 
> 2.42.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

