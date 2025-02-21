Return-Path: <bpf+bounces-52131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D229CA3E9AD
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 02:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636673AD7DF
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE703597E;
	Fri, 21 Feb 2025 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPv4HjLx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83F1DA53;
	Fri, 21 Feb 2025 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100321; cv=none; b=Q3wqwrHmkxGC3GGMY8DBMMyrMIpnKysL3quV5/Kh9/2V/1tNBwilDBhMcyXMNC8y/xw80r5lUVP6erogVNGLYO7V/Ump84WkqW7qsPfUAwBR8Aa5WuQpdVrRP4nv09ReJuqXbrptwfCthv+n5r9OLN/uIZo4EbiJzDQsonAkmOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100321; c=relaxed/simple;
	bh=Vm0MXbQfgbH48YR3avHkOxUhjZoB9IqDiPff7dH3jBc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DAgXtCssUnHUA6UvMfJztW+noXTbICwdFQNDiBgmdXO2B9+AxZp0xX+U8OEIssUduqPEDeXGKBDwrROlW033pZmkYjbs5MsjyCZ4P1Ky/MarPcRxBND48FTixQI4a76UrSZRCwwM26638WabaPuPtjHlV/1Ye+R8ru1W+ZPaUyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPv4HjLx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2211acda7f6so33147935ad.3;
        Thu, 20 Feb 2025 17:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740100319; x=1740705119; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vm0MXbQfgbH48YR3avHkOxUhjZoB9IqDiPff7dH3jBc=;
        b=iPv4HjLxqm1K820QM9wb9AHDbH52yugMUyDZIjKcqY80oVAhAV+SQEA94c5kequ4Uo
         VJkCxrTcj/3MWuGb4t/XCzfinZZ0UQKTS30FGUoQ/1zsE1sToK2/+pUsRdSsJHG7bAsq
         0tDBGszcjKHoTS8l2HKRcIFm2vsZhA7oDhnSZb3XJCHOmTSlAjEy93717R/k3EAZrXDe
         /Hv2JhBmI9PpTkbGnxuxbpIkmVU0JQR/kcW9ifr/Om1sqWIJgXczQlK50oWAbbh8q4xg
         b3FEPwj2zQ1NhRkA7NfY/mJ/7uQ4LEr24TrsaKc6AuBj7w6TPNkQnuq+qX08y8c3qiOK
         89RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100319; x=1740705119;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vm0MXbQfgbH48YR3avHkOxUhjZoB9IqDiPff7dH3jBc=;
        b=hTQ3NtAlL4Mzy9WHyLyTbKCaul2aKe+AsLDV8sgbhZYfVeV1VRvZmh4sQJzWSUym1z
         hsq7e4spAcDInFr1b5MrrvHLR+MMsJArwkkZjtgzeWZgzVZYco/W3qVIChnLqiExe3kX
         lbfLcPXWj5SmyPtT5Fndx8Q1aPVUG7ekwTTArl5n1ZHchTv/fatw7hN+zsiS+QxJ7DT4
         fovi6NzR97hQJgK4osbSxck4hsSB/hEG0ZhIGhqrtQVV+M3egutzp1i8B1/WLJNMLPXw
         mxybqqAr/Tnis706DiNDrcyFrwk10lnwLhwd7JTyoeMe4IcQn6l/mGCRcPbpUN3kSQWp
         iRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAMmtk5sYNJn3SnkM6pNCzf072WvSR42uLzdo6G59LIzL7lWaK0gl9hedEtgdLXZF9CbxzfJod0caInSgD@vger.kernel.org, AJvYcCXesxnl+IB0LgF0AmSB307u7T3e2l4TM2JGf8bcZB4dFNoZI8w5pmUyMZ/L934FHQTLpeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqkA0kEFbOnWLDUCWPlfReoZv2WxxDKHab81xWRCeA/f0K/QC6
	mEi5x6IN2ulyhByeGXXaRZvahFPzfk5RrrZAfxDO9Y7YJKERirzb
X-Gm-Gg: ASbGnctOAaCdzcjI/s829YA5BEk+Zk/yL9d6crI9HoOOdx+Oa0OkT1MpVjWJxEJaQkS
	XSPP4VP3K61u9den9NC8rWVAGHpOy/CNKYzOEB/haaZFuUQS3VGPiw4xpcicDGzQcSTSQVjZGUh
	52BteBynBnXL4sraQx6QSZCJqZ8HPm+E9OCeNhhQPeEsSByRDJzQ0Sqe1L3cy6e5AOvsZhvVzh8
	e6EbyFt8jabWqQk+gXB4zlqnj0/1/yA/1L4paia2l48EZOakl+gpK7oOAfz/VQsU/mIW0ihNZPy
	BtDgYv3x7O2i
X-Google-Smtp-Source: AGHT+IEoDhrb4CGE5jJ5LTwmx2lypbKMOqTBRBUmW4XbiAed9CM5h1ZXiovE1GldETPMqQMamBlFQQ==
X-Received: by 2002:a05:6a20:8426:b0:1ee:c598:7a96 with SMTP id adf61e73a8af0-1eef3c770bbmr2408661637.16.1740100319058;
        Thu, 20 Feb 2025 17:11:59 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5813a687sm11375535a12.20.2025.02.20.17.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 17:11:58 -0800 (PST)
Message-ID: <1fb198103e72d88c45caf6ef2dd8ebeb258ad48e.camel@gmail.com>
Subject: Re: [PATCH RESEND bpf-next v7 0/4] Add prog_kfunc feature probe
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Tao Chen <chen.dylane@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2025 17:11:54 -0800
In-Reply-To: <CAEf4BzYsGnhmnhkHdUPN8yBfbv57R9h4N2R8RcqdjhmHWvJVkg@mail.gmail.com>
References: <20250212153912.24116-1-chen.dylane@gmail.com>
	 <2b025df3-144b-4909-a2b4-66356540f71c@gmail.com>
	 <598a7d089936b18472937679d4131286f102cb18.camel@gmail.com>
	 <CAEf4BzYsGnhmnhkHdUPN8yBfbv57R9h4N2R8RcqdjhmHWvJVkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 17:07 -0800, Andrii Nakryiko wrote:
> On Tue, Feb 18, 2025 at 2:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Mon, 2025-02-17 at 13:21 +0800, Tao Chen wrote:

[...]

> > I tried the test enumerating all kfuncs in BTF and doing
> > libbpf_probe_bpf_kfunc for BPF_PROG_TYPE_{KPROBE,XDP}.
> > (Source code at the end of the email).
> >=20
> > The set of kfuncs returned for XDP looks correct.
> > The set of kfuncs returned for KPROBE contains a few incorrect entries:
> > - bpf_xdp_metadata_rx_hash
> > - bpf_xdp_metadata_rx_timestamp
> > - bpf_xdp_metadata_rx_vlan_tag
> >=20
> > This is because of a different string reported by verifier for these
> > three functions.
> >=20
> > Ideally, I'd write some script looking for
> > register_btf_kfunc_id_set(BPF_PROG_TYPE_***, kfunc_set)
> > calls in the kernel source code and extracting the prog type /
> > functions in the set, and comparing results of this script with
> > output of the test below for all program types.
> > But up to you if you'd like to do such rigorous verification or not.
> >=20
> > Otherwise patch-set looks good to me, for all patch-set:
> >=20
> > Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> Shouldn't we fix the issue with those bpf_xdp_metadata_* kfuncs? Do

I assume Tao would post a v8 with the fix.

> you have details on what different string verifier reports?

The string is "metadata kfuncs require device-bound program\n".

[...]


