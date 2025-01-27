Return-Path: <bpf+bounces-49846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F42FA1D35A
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 10:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC9E164CA5
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 09:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5931FCFFC;
	Mon, 27 Jan 2025 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="FDKZjSIS"
X-Original-To: bpf@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E84233C9;
	Mon, 27 Jan 2025 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970184; cv=none; b=OWFj43kPngo/Iuc1M6TCg/IVC6eayOpDsGwto14DsDgHmfu7/q6NzweIt0qTWrlYDl6hNHPKyYqpkdutpK+fLZdBIpHORry3dETrKlrNJuhpXCJOMhW2dhzz5Zi2SUaFY0xzyG6l1ZDTqAt7oS6952VrRMSzvWyMVQwcsZ3qYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970184; c=relaxed/simple;
	bh=N10ZCL64koVGzTXxqDWF/wmObGy7K2IovLNO8C00AAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtYVg/t+AKO8YJIrTSUd4lssjjSzp1bgZzpOqXqvloDXV+jnO1/Wlb1RZiWi5tQbRxhrGzAeuE5kviUiRNPDqeP5cCiTfdvHo3YZLJp6FEzljhDN1XN6waslFZf9ZXJa1Y6iWZ7NNObUwWseDV91xiaDyTVqGQ9YOXxcIeL8Spc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=FDKZjSIS; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1737970172; bh=N10ZCL64koVGzTXxqDWF/wmObGy7K2IovLNO8C00AAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDKZjSISdwIxtt507nuwWJAOKrN6fQvPZUgZuk0hDP89P+2gBaviZMaAIHT/99ooT
	 fTDtYW2PrTLRH3qj2/h48eciG0sfkKMBkggLhluIXfSWNswQmUm8C03GYHCJjTuVnB
	 fViMWFSRxNP6QE+AQVSgmg7HC8aSM9CwjqY603b0=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.52.1)
	(envelope-from <n.schier@avm.de>)
	id 679751fc-35e9-7f0000032729-7f000001ba38-1
	for <multiple-recipients>; Mon, 27 Jan 2025 10:29:32 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon, 27 Jan 2025 10:29:32 +0100 (CET)
Received: from l-nschier-nb (unknown [IPv6:2001:9e8:9fa:e101:5fb1:76a5:fd66:46b3])
	by mail-auth.avm.de (Postfix) with ESMTPSA id A6DF38061C;
	Mon, 27 Jan 2025 10:29:31 +0100 (CET)
Date: Mon, 27 Jan 2025 10:29:30 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ruowen Qin <ruqin@redhat.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] samples/hid: remove unnecessary -I flags from
 libbpf EXTRA_CFLAGS
Message-ID: <20250127-military-salamander-of-fame-3f6e1e@l-nschier-nb>
References: <20250123081950.173588-1-jinghao7@illinois.edu>
 <20250123081950.173588-2-jinghao7@illinois.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123081950.173588-2-jinghao7@illinois.edu>
X-purgate-ID: 149429::1737970172-BA441833-22AE9C9C/0/0
X-purgate-type: clean
X-purgate-size: 2171
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

On Thu, Jan 23, 2025 at 02:19:49AM -0600, Jinghao Jia wrote:
> Commit 5a6ea7022ff4 ("samples/bpf: Remove unnecessary -I flags from
> libbpf EXTRA_CFLAGS") fixed the build error caused by redundant include
> path for samples/bpf, but not samples/hid.
> 
> Apply the same fix on samples/hid as well.
> 
> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")

I can't see a relation between this patch and the referenced commit.
Can you please check whether the 'Fixes' is (still?) valid here?

Kind regards,
Nicolas



> Tested-by: Ruowen Qin <ruqin@redhat.com>
> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> ---
>  samples/hid/Makefile | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/samples/hid/Makefile b/samples/hid/Makefile
> index 8ea59e9631a3..69159c81d045 100644
> --- a/samples/hid/Makefile
> +++ b/samples/hid/Makefile
> @@ -40,16 +40,17 @@ BPF_EXTRA_CFLAGS += -I$(srctree)/arch/mips/include/asm/mach-generic
>  endif
>  endif
>  
> -TPROGS_CFLAGS += -Wall -O2
> -TPROGS_CFLAGS += -Wmissing-prototypes
> -TPROGS_CFLAGS += -Wstrict-prototypes
> +COMMON_CFLAGS += -Wall -O2
> +COMMON_CFLAGS += -Wmissing-prototypes
> +COMMON_CFLAGS += -Wstrict-prototypes
>  
> +TPROGS_CFLAGS += $(COMMON_CFLAGS)
>  TPROGS_CFLAGS += -I$(objtree)/usr/include
>  TPROGS_CFLAGS += -I$(LIBBPF_INCLUDE)
>  TPROGS_CFLAGS += -I$(srctree)/tools/include
>  
>  ifdef SYSROOT
> -TPROGS_CFLAGS += --sysroot=$(SYSROOT)
> +COMMON_CFLAGS += --sysroot=$(SYSROOT)
>  TPROGS_LDFLAGS := -L$(SYSROOT)/usr/lib
>  endif
>  
> @@ -112,7 +113,7 @@ clean:
>  
>  $(LIBBPF): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUTPUT)
>  # Fix up variables inherited from Kbuild that tools/ build system won't like
> -	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)" \
> +	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(COMMON_CFLAGS)" \
>  		LDFLAGS=$(TPROGS_LDFLAGS) srctree=$(HID_SAMPLES_PATH)/../../ \
>  		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
>  		$@ install_headers
> -- 
> 2.48.1
> 

