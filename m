Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8A7E3A6A
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2019 19:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394056AbfJXRyT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Oct 2019 13:54:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42472 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390064AbfJXRyT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Oct 2019 13:54:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id 21so4342835pfj.9
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=FHbGa3ER6wZpRAwAU1c1migL7nlX7O5LX92sLHEgyWU=;
        b=FSOA26uFfwBgfOB8QyYlOihVruT5XJrbSTPGhplaxgmoRb1zRwmxQD6CB4JyHieI4q
         wud/imuDc9O907NOZTz1cjDL0s4nyLS5zaq4mAmFsGST7Z/asS97pXuCs/mm6CCe9939
         EaDs2jlcsVc0QNMIqLQfYojH6zEAZopXkIg1446B7XCv4TI23PxlKCDmzIJj9ghcOenU
         ZzuuU6Z/oqjh3Yau+ozwI1Fp0wJ+B4stnSiFx5UekJ5w8KwI689e4QMh0mQmBGh1PtLf
         GUQJjiYAnJMQmANMki8E5ZiRMsa2p21CPdDz4yyktxear2U+8AA5RFv4K0SEUEEAfkXS
         rqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=FHbGa3ER6wZpRAwAU1c1migL7nlX7O5LX92sLHEgyWU=;
        b=mFTyF3IVheB6fDahp2rJ/EL35w/Q8UD/eRetc1G3oq9qWxlvGodKRi8Is6Vp/L4qIV
         S3uv4bJL8Pi2M7TrmYiiJ+0/Ym3LQ/iziXobWJm/xEwxHQCMkn+kmsxNs/fKFELmZ+IO
         lhTn/cwgd+n5SE5lgZQulhLOPlrFUAvRwJjv8TJneBslnu1mWxyRMV7z/G4s8HH1jcW1
         +gGS9+KK9i3gC2aI9+R1v8UzgvCoLD/JbMsqlU2G8Ukcp9ltZ37e4biy0IePZbrWwcbm
         2roen2UeIM5AILYQ8nA861Q8Tq6JF/VeSzdxZRCa/eto0x61eEpVX6Q9CE9yE2AbjjGx
         GQYA==
X-Gm-Message-State: APjAAAXuNxccu+z0InT9sF03FNCg7fS2qx95pfYTXPo0ZJv7E/Q63Umg
        ahrahvKIbsGoKk1aEUgK8395Kw==
X-Google-Smtp-Source: APXvYqw2+Qp3rmS2w8vU5VTZ7UId6S5CyCjH/s+z3owyJiGPvIZkwGVVPbA27jMq2j3g+aZa+rCWKg==
X-Received: by 2002:a63:cf18:: with SMTP id j24mr18548527pgg.406.1571939658771;
        Thu, 24 Oct 2019 10:54:18 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id h186sm34013244pfb.63.2019.10.24.10.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 10:54:18 -0700 (PDT)
Date:   Thu, 24 Oct 2019 10:54:14 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCHv2] bpftool: Try to read btf as raw data if elf read
 fails
Message-ID: <20191024105414.65f7e323@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20191024132341.8943-1-jolsa@kernel.org>
References: <20191024132341.8943-1-jolsa@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 24 Oct 2019 15:23:41 +0200, Jiri Olsa wrote:
> The bpftool interface stays the same, but now it's possible
> to run it over BTF raw data, like:
> 
>   $ bpftool btf dump file /sys/kernel/btf/vmlinux
>   [1] INT '(anon)' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>   [2] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
>   [3] CONST '(anon)' type_id=2

My knee jerk reaction would be to implement a new keyword, like:

$ bpftool btf dump rawfile /sys/kernel/btf/vmlinux

Or such. But perhaps the auto-detection is the standard way of dealing
with different formats in the compiler world. Regardless if anyone has
an opinion one way or the other please share!!

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> v2 changes:
>  - added is_btf_raw to find out which btf__parse_* function to call
>  - changed labels and error propagation in btf__parse_raw 
>  - drop the err initialization, which is not needed under this change

The code looks good, thanks for the changes! One question below..

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 9a9376d1d3df..a7b8bf233cf5 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c

> +static bool is_btf_raw(const char *file)
> +{
> +	__u16 magic = 0;
> +	int fd;
> +
> +	fd = open(file, O_RDONLY);
> +	if (fd < 0)
> +		return false;
> +
> +	read(fd, &magic, sizeof(magic));
> +	close(fd);
> +	return magic == BTF_MAGIC;

Isn't it suspicious to read() 2 bytes into an u16 and compare to a
constant like endianness doesn't matter? Quick grep doesn't reveal
BTF_MAGIC being endian-aware..

> +}
> +
>  static int do_dump(int argc, char **argv)
>  {
>  	struct btf *btf = NULL;
> @@ -465,7 +516,11 @@ static int do_dump(int argc, char **argv)
>  		}
>  		NEXT_ARG();
>  	} else if (is_prefix(src, "file")) {
> -		btf = btf__parse_elf(*argv, NULL);
> +		if (is_btf_raw(*argv))
> +			btf = btf__parse_raw(*argv);
> +		else
> +			btf = btf__parse_elf(*argv, NULL);
>  		if (IS_ERR(btf)) {
>  			err = PTR_ERR(btf);
>  			btf = NULL;

