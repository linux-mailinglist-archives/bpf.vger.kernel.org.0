Return-Path: <bpf+bounces-61774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8E4AEC0A6
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 22:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935981C45C78
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 20:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDE02EBDC2;
	Fri, 27 Jun 2025 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YesoE2tn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE8C2D97BF
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054841; cv=none; b=c9KrWF4IPr2rEnsYR7h8NEGhulcm3ryq17nqb0zALpO7Kzdc473hr4OKHJ+8Mhbgy6VOzb7wQ0KG4e6D30jwA8Sib2QZbRc6flF3O+vrjftvgmZTiCPnqr0mw/8pdTkQPmTcHfmM0UNUt+VNmbn48nWC1A4+b/zFF6qzvpqYCSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054841; c=relaxed/simple;
	bh=iB/bksZD2Sc3BnODiqahWIsiV12hyEHCJLEJS9MNdqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xc3neO6NqcrwDjiHtCkQDUyPLBUHAZgmfRp6fo3RUD5J0UXgHAqUscTeQjofD8uSS9TqIRwjN+1n/gEaN/decyHobUIChFC0aD7olGSdxcXkI6g1r0gqHEWU1PTxQXuvG75NEKKeuDXyhiH+3WsbtK9/ahOV/Ol4vD+sQjbHncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YesoE2tn; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so381585a12.3
        for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751054839; x=1751659639; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=erhWOx76Ah4FS4WCQNnfkttQM/hGtkdth47xrulGB3s=;
        b=YesoE2tna00BNsD1yV2YQFzcihOkB5gmQLYW0Sn5thcdDMQEnZfBpdBrDTSzXclOuK
         70n8MoSVrb+hBetzzye050ccyzB1bqoPoRpI5Q2rjeALIGPIPtJnnahe3p81sr8fnfYM
         FaHxNDpdq1vfB24IYkeFXzgHBIwwJtyP54eC4xzObkoR23TbIpmYfc0HmNFi5yMb52tg
         okfi6RrGoKCJS5LrCKUfYounAnB2rsKI40rpx0se+ZqW0QHDnk675hjMlf7DuLTrrEB9
         eHiyHyKqtCgehi0yq5Oogdn7byYaa6aL+c06QGhYWNudf2Mqcw57DcHNkKt0p4XG4Qpx
         /dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751054839; x=1751659639;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=erhWOx76Ah4FS4WCQNnfkttQM/hGtkdth47xrulGB3s=;
        b=Ccf2dj6zM8egllhg/ttgKVTJL+u/8bo4KUEA5p+BZG4fa5BSrvgPH2v24jHLgNAhlb
         zRtEPlFgAvS41lPfCTBn/NvqKHM2S7RKvyn9iF0Rz7/4KY5iA7C837bJzY8jfoyhiPBm
         dSd2edupybgXClLXgH8924ysDPdQPFT4MfFZcHMatweZhTWbYte8XlNXgT2CMxFxS98e
         R5Mwp4sJNlFUuhO5OXSYskxeWQJPdvRHsPux+aA/YLLbw2aUCzOBnVrmP+lgcx8OiLGm
         IXytHJ2dR1wCOkQ3WFZN3DZ5VU5PogGUggHtYQc214H4q3J/K01TcqI4fLjhQiJUWD4N
         cCEA==
X-Forwarded-Encrypted: i=1; AJvYcCU0ecQI2yneTjcHqZr4VTI3kP240HU8xpU6SPsCEdKpXzE7L5k+JRX7JmTmvMvHKhl8r9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxXmIFO6cSmDzHZQeicoSu+DEyVj9EUSicHzCy0qcPfeFhBJsA
	PUFqy4z7ZdeDHMXPpYa7UzlpNpG6ceVd0wuSOVn/MaAEfhf3uX9J4xpX
X-Gm-Gg: ASbGncs5oJcnJAx5Z/bJWWizC0Or9yZoRl9f743lPMVekHvrPxCuskLhhprNF0PRf+E
	Rwmm/uzJJpDevzjnBCkETdXjtH4TsoJbjfOfoHHKG/j72GJjF0vFfcj7C9VT2Z63cl5CdeS26Cw
	AB3a6GKxuZfVorLN8PIWjgNWju0TU4M3GO+iO5D4DdPoez3xcVJUIeVL02ByY1Ivt+X+IFohOf4
	yt2Ot5ma34GQlKZhX3woHdZlBX23NFEfWOrg7CLXh1LpzGrwiTbkMt6Ev/OBAfRQ770fbmbiFmf
	f6pnSNLYESn9XxOq92XTJcv3tHHMYqy+2xFbJNgH/7t0MJgOIMBZs2V+/DE=
X-Google-Smtp-Source: AGHT+IGEKK3AC9HSO5+qaBraVHlpewjsIpoDrMtlxtgGpHKOVwSFYF4IdLmq7WyrB+VNk9JuiDlixQ==
X-Received: by 2002:a17:90b:3ccb:b0:312:26d9:d5b2 with SMTP id 98e67ed59e1d1-318c8d35f9cmr7666675a91.0.1751054839198;
        Fri, 27 Jun 2025 13:07:19 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5382f02sm7385090a91.1.2025.06.27.13.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 13:07:18 -0700 (PDT)
Message-ID: <1105029abe7a7d561a492240b47531f0cc7e93d5.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: improve error messages in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 27 Jun 2025 13:07:17 -0700
In-Reply-To: <f6de5879-0984-4de0-af6f-62f091bb0dd0@gmail.com>
References: <20250627144342.686896-1-mykyta.yatsenko5@gmail.com>
	 <c49fcfaf3b622b8e71e33a3928c6494f29aa486d.camel@gmail.com>
	 <f6de5879-0984-4de0-af6f-62f091bb0dd0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-27 at 21:01 +0100, Mykyta Yatsenko wrote:

[...]

> > > @@ -1955,6 +1967,8 @@ static int adjust_var_secinfo(struct btf *btf, =
const struct btf_type *t,
> > >   			break;
> > >   		case FIELD_NAME:
> > >   			err =3D adjust_var_secinfo_member(btf, base_type, 0, atom->name,=
 sinfo);
> > > +			if (err =3D=3D -ESRCH)
> > > +				fprintf(stderr, "Can't find '%s'\n", atom->name);
> > Nit: adjust_var_secinfo_member() already reports a few errors,
> >       maybe report this error there as well?

> That was my first attempt, but adjust_var_secinfo_member is called=20
> recursively for anonymous embedded structures, so this particular error=
=20
> will be noisy, as it'll get triggered for every embedded structure.=20
> Placing error msg here makes sure it's printed just once and only in=20
> cases when member is not present anywhere.

Makes sense, thank you for explaining.

