Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19EAF11922F
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2019 21:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfLJUga (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 15:36:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36906 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJUga (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Dec 2019 15:36:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so326857plz.4
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 12:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=m4lR4/qTA+x4lWMCsr3lyiJ3HAGpeNIlbEfrqpGeIOA=;
        b=bs/R1E7G9tgGFY/AMt4YyATQFUGcQ8I8p3F5bR1m+TQwtRXsRmSgksbFpsBm2S0+vS
         kRvmNORmijmV/cHnjinZstjpOAnj7Ag/LbfBqvWxD4wLM5eeqZHIUm/iLvNqtbn3Mmhz
         N2QvGNzaC5Sq0VqOIHFQ0BSxgEbQ3JyeC3S/RB/kGQA4Wbk4aGph3VjsWBTxJ2Jy25Tf
         bdZs3looOP8sLwmM2iWoRP7m3XX7pLXzQBTnwbuBu/7y2rFQCzEh+VtnMbpAaRHBwekM
         OAFJANW8JV9KHZ5DZYD/c8BPfSAfoJyoG2veG6rOQp+vKn0hpiwl7OiZJIT6J+Awkskv
         yGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=m4lR4/qTA+x4lWMCsr3lyiJ3HAGpeNIlbEfrqpGeIOA=;
        b=dr+q6lwfk+cV/HBFWJrnxGyOBB12DT39mB6w1WKcR4pa4q9VO/OQE72zEmHm8Az7Js
         OnAmTBUqw+CTubHYEDrS5514dBXDEZZcdNw2IIhvYL/DF0VV1krVtdFcmOonQF0IaxRK
         R6rnT1tQpW/E81Wmxv/KmlCXQurGE76h4bAs1NONMLvYIu4T7IzcOyNWy3Q8+9/s/VHv
         3G0mEY0KDXEsS5ce7pfSGtWb3za7glB5d1UmrzCDdGuTJRyETLqg33JdnySNvxH2xTv1
         6GZyrUx4dpxEVbjXg5imaLX5SxxmVWrf/5Hs/L2efNPBjH45NHQ6THYfD4r5DgNnbp1I
         IYWQ==
X-Gm-Message-State: APjAAAVqHQ7okDd4u0ok2BIQI5mv4L6rLHe/+eEBLogK97qFpHSSD5gd
        Brf1dLLIsDJydPjyrghVKgKy/g==
X-Google-Smtp-Source: APXvYqxMj8JfspXi3A7BnpdrN+zZp2PrEV/FNY20PzoFuq2pIqCf/p8ugcaEJRUbyLNRgIgDEgqy+g==
X-Received: by 2002:a17:902:d88f:: with SMTP id b15mr34612369plz.172.1576010189331;
        Tue, 10 Dec 2019 12:36:29 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id a15sm4653619pfh.169.2019.12.10.12.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:36:29 -0800 (PST)
Date:   Tue, 10 Dec 2019 12:36:25 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Paul Chaignon <paul.chaignon@orange.com>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin.monnet@netronome.com>,
        paul.chaignon@gmail.com, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next 1/3] bpftool: match several programs with same
 tag
Message-ID: <20191210123625.48ab21fa@cakuba.netronome.com>
In-Reply-To: <4db34d127179faafd6eca408792222c922969904.1575991886.git.paul.chaignon@orange.com>
References: <cover.1575991886.git.paul.chaignon@orange.com>
        <4db34d127179faafd6eca408792222c922969904.1575991886.git.paul.chaignon@orange.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 10 Dec 2019 17:06:25 +0100, Paul Chaignon wrote:
> When several BPF programs have the same tag, bpftool matches only the
> first (in ID order).  This patch changes that behavior such that dump and
> show commands return all matched programs.  Commands that require a single
> program (e.g., pin and attach) will error out if given a tag that matches
> several.  bpftool prog dump will also error out if file or visual are
> given and several programs have the given tag.
>=20
> In the case of the dump command, a program header is added before each
> dump only if the tag matches several programs; this patch doesn't change
> the output if a single program matches.

How does this work? Could you add examples to the commit message?

This header idea doesn't seem correct, aren't id and other per-instance
fields only printed once?

> Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>

> -		close(fd);
> +		if (nb_fds > 0) {
> +			tmp =3D realloc(fds, (nb_fds + 1) * sizeof(int));
> +			if (!tmp) {
> +				p_err("failed to realloc");
> +				goto err_close_fd;
> +			}
> +			fds =3D tmp;

How does this work? the new array is never returned to the caller, and
the caller will most likely access freed memory, no?

> +		}
> +		fds[nb_fds++] =3D fd;
>  	}
> +
> +err_close_fd:
> +	close(fd);
> +err_close_fds:
> +	for (nb_fds--; nb_fds >=3D 0; nb_fds--)
> +		close(fds[nb_fds]);
> +	return -1;
>  }

> +int prog_parse_fd(int *argc, char ***argv)
> +{
> +	int *fds =3D NULL;
> +	int nb_fds, fd;
> +
> +	fds =3D malloc(sizeof(int));
> +	if (!fds) {
> +		p_err("mem alloc failed");
> +		return -1;
> +	}
> +	nb_fds =3D prog_parse_fds(argc, argv, fds);
> +	if (nb_fds !=3D 1) {
> +		if (nb_fds > 1) {
> +			p_err("several programs match this handle");
> +			for (nb_fds--; nb_fds >=3D 0; nb_fds--)

nit: since you checked nb_fds is positive, while (nb_fds--) ?

> +				close(fds[nb_fds]);
> +		}
> +		fd =3D -1;
> +		goto err_free;
> +	}
> +
> +	fd =3D fds[0];
> +err_free:

nit: we tried to call the labels exit_xyz if the code is used on both
     error and success path, but maybe that pattern got lost over time.

> +	free(fds);
> +	return fd;
> +}
> +
>  static void show_prog_maps(int fd, u32 num_maps)
>  {
>  	struct bpf_prog_info info =3D {};

>  static int do_show(int argc, char **argv)
>  {
> +	int fd, nb_fds, i;
> +	int *fds =3D NULL;
>  	__u32 id =3D 0;
>  	int err;
> -	int fd;
> =20
>  	if (show_pinned)
>  		build_pinned_obj_table(&prog_table, BPF_OBJ_PROG);
> =20
>  	if (argc =3D=3D 2) {
> -		fd =3D prog_parse_fd(&argc, &argv);
> -		if (fd < 0)
> +		fds =3D malloc(sizeof(int));
> +		if (!fds) {
> +			p_err("mem alloc failed");
>  			return -1;
> +		}
> +		nb_fds =3D prog_parse_fds(&argc, &argv, fds);
> +		if (nb_fds < 1)
> +			goto err_free;
> =20
> -		err =3D show_prog(fd);
> -		close(fd);
> -		return err;
> +		if (json_output && nb_fds > 1)
> +			jsonw_start_array(json_wtr);	/* root array */
> +		for (i =3D 0; i < nb_fds; i++) {
> +			err =3D show_prog(fds[i]);
> +			close(fds[i]);
> +			if (err) {
> +				for (i++; i < nb_fds; i++)
> +					close(fds[i]);
> +				goto err_free;

I'm 90% sure JSON arrays close/end themselves on exit =F0=9F=A4=94

> +			}
> +		}
> +		if (json_output && nb_fds > 1)
> +			jsonw_end_array(json_wtr);	/* root array */
> +
> +		return 0;
> +
> +err_free:
> +		free(fds);
> +		return -1;

Perhaps move the argc =3D=3D 2 code to a separate function?

>  	}
> =20
>  	if (argc)
> @@ -408,101 +500,32 @@ static int do_show(int argc, char **argv)
>  	return err;
>  }

