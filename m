Return-Path: <bpf+bounces-65933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD81B2B53D
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 02:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B78C6229C4
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 00:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574FC1CA81;
	Tue, 19 Aug 2025 00:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJOMb8xF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C56134CF
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755562709; cv=none; b=B2DH9TdWU6QliOfHIbiC3CSkDo/bRdc1v1gF8ji6Ysox9w0AFL0BDxGzDZ1LMG5SsH39CIdZzF80hIoC48HlaUNw8yB+VR9Vc2WAnPuYmnPt6h5hRrZU7faJIX7eXox8bc//1JRzrKfdbcLbZjb+h3ugqMGucsnRnXvNUNRFKtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755562709; c=relaxed/simple;
	bh=wbHoa9Zum98fACStb+n9QVgCLR3F3k2KjFq32REf/aA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qbZ4U98/1XjZi9xe5oQc7l0NQncM5OBGKlopkp/zavWM0MaItZZbv8u5UTOapgxpYfgwvwV7nUiB2CyfTM+3axeLvwAYBF3HLIGjByMopamexYWO2gJ5matoJr8d7ld1iBLpZi5SS5Kz8BEks1MdS8DrzxzTm4YTDbTuZHG8PRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJOMb8xF; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e6cbb9956so1132772b3a.0
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 17:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755562708; x=1756167508; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rvu4iZvneMDH0On0UE9POCzDeEeJGqgtyUpX/7xCF+g=;
        b=cJOMb8xFk8gyM3S+g9aNAkqwR6QgNnPgVDxp6OHoRjsGG12gBxU45sqXLXdQkdgx2+
         Dol7GRcPdsAM54M44i9Yl/KnIexF3QujXf9ufNSmVO5c2aXEm2XDkDerZVr4dvtRpguS
         NoY5ey8JeL2OZUEPCuum17MjyXFIAUg7+SwXNCi8iLCc+zbSHnATwFYU1EIISB2s8y+c
         +Td+cA8eUMpbOyXHok59jEhrHxjlUaeIbk+5LFh7xGVznczOsc2RogaT7KjsCd1SLJo4
         HrGrAMFW6cM+Bgft3ZtxBZCn7FuRTqeWsVMDXslJ9Ppc51N1FWW/x1g+s+gPfY7a9WmJ
         daBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755562708; x=1756167508;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rvu4iZvneMDH0On0UE9POCzDeEeJGqgtyUpX/7xCF+g=;
        b=KHe/fAvDTaiHn2Kv378QSi7qYF/4GugRcuGjkHg9ikp8dWsPGD/2HYRqpm5npAcgVy
         G+2I6ErgGZwF42SemKCy2xW/z1s457yoiK599c1DxUcWCB6CGc2SN+51Iu+2zPlUZoFw
         Ga9i5zUMj0ync0aof+N1sHPJO68GcAEXIfsg1+2xxlEPsZTP7v2fAjxAJ5xu19vLK8iq
         xh9jWjQkCGoMtHHB6nU1AZDNxjANdUREdhu/c1k8nrQKri8xoW6jSoIKFvVqIncivb6U
         QmdRttvmvz8pUH8XAQkAvct2F3Q/4Jym2yPspc/WLrHv8g3dt7MGe/vgLWK9PvzoaIhR
         kQrg==
X-Forwarded-Encrypted: i=1; AJvYcCWoNJiWuBA9raNcrXaUJe3ux9CA3WCpyvULkLYGHsEc8EbaIxpj2Dxlxk6bsCaiNl+WczM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymQGejOctrJ0S4p7/MR2A1Cf7/6F2yLWlBNyNrZ/Sz6YENXTLf
	FbNrMHLZw6QFWb0MwGu3aDe/akLm/2e+6W+quXw/gAXTCimbafMRbMp8
X-Gm-Gg: ASbGnctUPMMS34pL8XI09EJBfkDKuS4jOPM+oL2KxgvYEGlVqJgRauMPJVJpNmN5kIa
	egylRDuaDPCDvWNTFJlPO99/LvuvkkSE5DXMigrSUO6Y4+b7S1XA2Ft86O6iSlEjXAWbw0KdgWp
	FzCm8yZLz/Vuf4YYygDBxQO29SANmRpC/QG9OOPWQl12WU2UB1YWAV+UAxwnhi+/Q8+Sxbra6ld
	HZGGONXe8PuM0g9I9pOM3jYcBpOshiKTDgsTDj5y54EVdWDtNAVb0m2ubfntb4o2r0zGdadYTLa
	VC3LPGH/7oX3mlh0Nq7e+3RqjlKLje8dzA6KFgagf5A9emEWw8v1zLr4F4rcb7Ck6QnF/KSH2ju
	S39n/53a2o3SExyjfyRUAJCPE1w==
X-Google-Smtp-Source: AGHT+IEsilvOaoOMQ48jsGUl+RJzKyx6LFZ9HTx/ygsvurxS3WlmyRzsC1p/BzQAtsYGq3eUAleMnQ==
X-Received: by 2002:a05:6a21:6da6:b0:240:1b13:459f with SMTP id adf61e73a8af0-2430d30ce72mr707589637.7.1755562707583;
        Mon, 18 Aug 2025 17:18:27 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::f? ([2620:10d:c090:600::1:e786])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f83602sm12514412a91.7.2025.08.18.17.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 17:18:27 -0700 (PDT)
Message-ID: <4f5238d786e4393184b27abb58bcb5a87852819b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: add BPF program dump in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 18 Aug 2025 17:18:25 -0700
In-Reply-To: <20250818180424.58835-1-mykyta.yatsenko5@gmail.com>
References: <20250818180424.58835-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-18 at 19:04 +0100, Mykyta Yatsenko wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index d532dd82a3a8..3ba06f532bfa 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -181,6 +181,12 @@ struct var_preset {
>  	bool applied;
>  };
> =20
> +enum dump_mode {
> +	NO_DUMP =3D 0,
> +	XLATED,
> +	JITED,
> +};
> +
>  static struct env {
>  	char **filenames;
>  	int filename_cnt;
> @@ -227,6 +233,7 @@ static struct env {
>  	char orig_cgroup[PATH_MAX];
>  	char stat_cgroup[PATH_MAX];
>  	int memory_peak_fd;
> +	enum dump_mode dump_mode;
>  } env;
> =20
>  static int libbpf_print_fn(enum libbpf_print_level level, const char *fo=
rmat, va_list args)
> @@ -295,6 +302,7 @@ static const struct argp_option opts[] =3D {
>  	  "Force BPF verifier failure on register invariant violation (BPF_F_TE=
ST_REG_INVARIANTS program flag)" },
>  	{ "top-src-lines", 'S', "N", 0, "Emit N most frequent source code lines=
" },
>  	{ "set-global-vars", 'G', "GLOBAL", 0, "Set global variables provided i=
n the expression, for example \"var1 =3D 1\"" },
> +	{ "dump", 'p', "DUMP", 0, "Print BPF program dump" },

Nit: describe that it should be either '-p xlated' or '-p jited'?

>  	{},
>  };
> =20
> @@ -427,6 +435,16 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
>  			return err;
>  		}
>  		break;
> +	case 'p':
> +		if (strcmp(arg, "jited") =3D=3D 0) {
> +			env.dump_mode =3D JITED;
> +		} else if (strcmp(arg, "xlated") =3D=3D 0) {
> +			env.dump_mode =3D XLATED;
> +		} else {
> +			fprintf(stderr, "Unrecognized dump mode '%s'\n", arg);
> +			return -EINVAL;
> +		}
> +		break;
>  	default:
>  		return ARGP_ERR_UNKNOWN;
>  	}
> @@ -1554,6 +1572,26 @@ static int parse_rvalue(const char *val, struct rv=
alue *rvalue)
>  	return 0;
>  }
> =20
> +static void dump(int prog_fd)
                    ^^^^^^^^^^^
		    Nit: prog_id

> +{
> +	char command[512];
> +	char buf[1024];
> +	FILE *fp;
> +
> +	snprintf(command, sizeof(command), "bpftool prog dump %s id %d",
> +		 env.dump_mode =3D=3D JITED ? "jited" : "xlated", prog_fd);
> +	fp =3D popen(command, "r");

Silly question, would it be sufficient to just do "system()" and forgo
the loop below?

> +	if (!fp) {
> +		fprintf(stderr, "Can't run bpftool\n");
> +		return;
> +	}
> +

Could you please insert some header (program name)/footer (newline)?

> +	while (fgets(buf, sizeof(buf), fp))
> +		printf("%s", buf);
> +
> +	pclose(fp);
> +}
> +
>  static int process_prog(const char *filename, struct bpf_object *obj, st=
ruct bpf_program *prog)
>  {
>  	const char *base_filename =3D basename(strdupa(filename));
> @@ -1630,8 +1668,11 @@ static int process_prog(const char *filename, stru=
ct bpf_object *obj, struct bpf
> =20
>  	memset(&info, 0, info_len);
>  	fd =3D bpf_program__fd(prog);
> -	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=3D 0)
> +	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=3D 0) {
>  		stats->stats[JITED_SIZE] =3D info.jited_prog_len;
> +		if (env.dump_mode !=3D NO_DUMP)
> +			dump(info.id);
> +	}
> =20
>  	parse_verif_log(buf, buf_sz, stats);
> =20

Note: below this hunk there is the following code:

          if (env.verbose) {
                  printf(format: "PROCESSING %s/%s, DURATION US: %ld, VERDI=
CT: %s, VERIFIER LOG:\n%s\n",
                         filename, prog_name, stats->stats[DURATION],
                         err ? "failure" : "success", buf);
          }

It looks a bit strange, that program is printed before the above
header is printed.

