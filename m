Return-Path: <bpf+bounces-393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB9D700760
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 13:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA0B281A3F
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26B4D52A;
	Fri, 12 May 2023 11:58:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4717F0
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 11:58:45 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BDE1387B
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 04:58:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so14932358a12.2
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683892702; x=1686484702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/kSwMo+7Cp5Lv8ExhFOieHNnTxisOO+ZhomyzvgiZA=;
        b=GtkEme0zKuovaryGssj8tMqP+nyf8Vw3X+iZZ4vCTtoOmR3TR6+TIRzEr40AKGYpi3
         90RA9l+bP9+orRpNX/kkNBaYB4SVEPDTZnJZKeVNlIulxteT5UAq31+V3mGkT+fhIqYI
         P3dWSo/OAwLS8Clj7HYFMD9EHPFxntyZTKSsGsEEYHuBEBsSJUAawg63vnWEa9cI8Nqn
         r1Hcqza/fDeULiQZAougs1xTeFqcDGoqipXymWOiilLIHtBMunk+IZsVd4urhSxDJJ/N
         LSvHSXk6voIhTE7J2ChWu73gJciH/0fnPypGfAMjyvIAEzgw57aiNrM3xSpLiBjmVnAd
         JAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683892702; x=1686484702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/kSwMo+7Cp5Lv8ExhFOieHNnTxisOO+ZhomyzvgiZA=;
        b=YIC7un7qqxE32yIYDm7A9dR4e1F+E4X2wspqJXZ/toQqfSd8QDRwpxnhZnXM0KLoSm
         naxlnXIJXXS/RpdS3K7+AMFQRNzyZeghIkudNMtlvtq0WopP7N4omFUPYkPU86GghICD
         kjrd7SnOPsh3ZRH8h7btJAL1vmMbHhNy/9756oO/rRv+3/mZ6lS48gCWRygjCORcXVz7
         4OCecYOiUAia1jM7Xq7J8S8egcvd8k/Rj1m/jLHUrQbQrHzz/rYWF6hilF/bKRfO4YBd
         n00ZpCu0bVT2UVMYkF1xvEr1qq5h/VROEKLejOdFTArsE0HqB8ujQABPFiYD0XHfDcrz
         X0KA==
X-Gm-Message-State: AC+VfDx2F/XgQgpjUxYr0yV/zxF32ko4+6g1mGrcj11pEb9M3DLPLViB
	VozLZ4KEr0HtfXbTC9I/A54=
X-Google-Smtp-Source: ACHHUZ7aKWXfMfpGDAZ0cCs52qruiFHVcsYeDwT8AScaYppop89g577DITwDvc7kogmzrVAC8yjtqQ==
X-Received: by 2002:a17:906:9c83:b0:94f:3074:14fe with SMTP id fj3-20020a1709069c8300b0094f307414femr23932949ejc.17.1683892701271;
        Fri, 12 May 2023 04:58:21 -0700 (PDT)
Received: from krava (213-240-85-134.hdsl.highway.telekom.at. [213.240.85.134])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906195000b0094e96e46cc0sm5291101eje.69.2023.05.12.04.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 04:58:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 12 May 2023 13:58:14 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, kuba@kernel.org,
	bpf@vger.kernel.org, Nicky Veitch <nicky.veitch@oracle.com>
Subject: Re: [PATCH bpf] tools: bpftool: JIT limited misreported as negative
 value on aarch64
Message-ID: <ZF4p1qAaJ1UwjInt@krava>
References: <20230512113134.58996-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512113134.58996-1-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 12, 2023 at 12:31:34PM +0100, Alan Maguire wrote:
> On aarch64, "bpftool feature" reports an incorrect BPF JIT limit:
> 
> $ sudo /sbin/bpftool feature
> Scanning system configuration...
> bpf() syscall restricted to privileged users
> JIT compiler is enabled
> JIT compiler hardening is disabled
> JIT compiler kallsyms exports are enabled for root
> skipping kernel config, can't open file: No such file or directory
> Global memory limit for JIT compiler for unprivileged users is -201326592 bytes
> 
> This is because /proc/sys/net/core/bpf_jit_limit reports
> 
> $ sudo cat /proc/sys/net/core/bpf_jit_limit
> 68169519595520
> 
> ...and an int is assumed in read_procfs().  Change read_procfs()
> to return a long to avoid negative value reporting.
> 
> Fixes: 7a4522bbef0c ("tools: bpftool: add probes for /proc/ eBPF parameters")
> Reported-by: Nicky Veitch <nicky.veitch@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/bpf/bpftool/feature.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index da16e6a27ccc..0675d6a46413 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c
> @@ -167,12 +167,12 @@ static int get_vendor_id(int ifindex)
>  	return strtol(buf, NULL, 0);
>  }
>  
> -static int read_procfs(const char *path)
> +static long read_procfs(const char *path)
>  {
>  	char *endptr, *line = NULL;
>  	size_t len = 0;
>  	FILE *fd;
> -	int res;
> +	long res;
>  
>  	fd = fopen(path, "r");
>  	if (!fd)
> @@ -194,7 +194,7 @@ static int read_procfs(const char *path)
>  
>  static void probe_unprivileged_disabled(void)
>  {
> -	int res;
> +	long res;
>  
>  	/* No support for C-style ouptut */
>  
> @@ -216,14 +216,14 @@ static void probe_unprivileged_disabled(void)
>  			printf("Unable to retrieve required privileges for bpf() syscall\n");
>  			break;
>  		default:
> -			printf("bpf() syscall restriction has unknown value %d\n", res);
> +			printf("bpf() syscall restriction has unknown value %ld\n", res);
>  		}
>  	}
>  }
>  
>  static void probe_jit_enable(void)
>  {
> -	int res;
> +	long res;
>  
>  	/* No support for C-style ouptut */
>  
> @@ -245,7 +245,7 @@ static void probe_jit_enable(void)
>  			printf("Unable to retrieve JIT-compiler status\n");
>  			break;
>  		default:
> -			printf("JIT-compiler status has unknown value %d\n",
> +			printf("JIT-compiler status has unknown value %ld\n",
>  			       res);
>  		}
>  	}
> @@ -253,7 +253,7 @@ static void probe_jit_enable(void)
>  
>  static void probe_jit_harden(void)
>  {
> -	int res;
> +	long res;
>  
>  	/* No support for C-style ouptut */
>  
> @@ -275,7 +275,7 @@ static void probe_jit_harden(void)
>  			printf("Unable to retrieve JIT hardening status\n");
>  			break;
>  		default:
> -			printf("JIT hardening status has unknown value %d\n",
> +			printf("JIT hardening status has unknown value %ld\n",
>  			       res);
>  		}
>  	}
> @@ -283,7 +283,7 @@ static void probe_jit_harden(void)
>  
>  static void probe_jit_kallsyms(void)
>  {
> -	int res;
> +	long res;
>  
>  	/* No support for C-style ouptut */
>  
> @@ -302,14 +302,14 @@ static void probe_jit_kallsyms(void)
>  			printf("Unable to retrieve JIT kallsyms export status\n");
>  			break;
>  		default:
> -			printf("JIT kallsyms exports status has unknown value %d\n", res);
> +			printf("JIT kallsyms exports status has unknown value %ld\n", res);
>  		}
>  	}
>  }
>  
>  static void probe_jit_limit(void)
>  {
> -	int res;
> +	long res;
>  
>  	/* No support for C-style ouptut */
>  
> @@ -322,7 +322,7 @@ static void probe_jit_limit(void)
>  			printf("Unable to retrieve global memory limit for JIT compiler for unprivileged users\n");
>  			break;
>  		default:
> -			printf("Global memory limit for JIT compiler for unprivileged users is %d bytes\n", res);
> +			printf("Global memory limit for JIT compiler for unprivileged users is %ld bytes\n", res);
>  		}
>  	}
>  }
> -- 
> 2.31.1
> 

