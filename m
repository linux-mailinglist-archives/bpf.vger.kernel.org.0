Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBF42FEBBC
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 14:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbhAUNZ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 08:25:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729332AbhAUNXA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 08:23:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42E49206A3;
        Thu, 21 Jan 2021 13:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611235320;
        bh=UjXbo6X5Wtuz9N/wlwTIdxCm913bAZDJsk9ttKjD7DY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/Gc4jkU86RKBW/mcu8fc4KF5TznoPhkL8ic2OqFGZ0iawZirU4wO4iLJudHYqLYM
         nRgz46v0lLqoQrppMpy7ZDFX3UdWFVj0a4arIsskYJgCDwQtyveeAbWZN3NHJqOTiV
         9InfindVCIHaODwe8DAxftDEuz04TvGj+kkK/Gc7YVKrEIQd4YK0OBixxwSdnLfZCv
         +fvFnm405j+UXNMmElXFgoAaMRF0WhiqS3Z/cdDAWQgRXW9yOqBO/P1boGGk6et0hv
         1CSqwSpnzDZTdmAXOLWgBmUUZYtNo9vCcbggPyXOFOPSlPxZunGYfiRhLoGUf9nXtr
         Pi7TuKpsWjSWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 311CF40513; Thu, 21 Jan 2021 10:21:58 -0300 (-03)
Date:   Thu, 21 Jan 2021 10:21:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org, kernel-team@android.com,
        maennich@google.com, ast@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH dwarves v2 1/3] btf_encoder: Fix handling of restrict
 qualifier
Message-ID: <20210121132158.GX12699@kernel.org>
References: <20210118160139.1971039-1-gprocida@google.com>
 <20210121113520.3603097-1-gprocida@google.com>
 <20210121113520.3603097-2-gprocida@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121113520.3603097-2-gprocida@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jan 21, 2021 at 11:35:18AM +0000, Giuliano Procida escreveu:
> This corrects a typo that resulted in 'restrict' being treated as 'const'.
> 
> Fixes: 48efa92933e8 ("btf_encoder: Use libbpf APIs to encode BTF type info")

Thanks for providing the Fixes: tag!

Applied,

- Arnaldo

 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---
>  libbtf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libbtf.c b/libbtf.c
> index 16e1d45..3709087 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -417,7 +417,7 @@ int32_t btf_elf__add_ref_type(struct btf_elf *btfe, uint16_t kind, uint32_t type
>  		id = btf__add_const(btf, type);
>  		break;
>  	case BTF_KIND_RESTRICT:
> -		id = btf__add_const(btf, type);
> +		id = btf__add_restrict(btf, type);
>  		break;
>  	case BTF_KIND_TYPEDEF:
>  		id = btf__add_typedef(btf, name, type);
> -- 
> 2.30.0.296.g2bfb1c46d8-goog
> 

-- 

- Arnaldo
