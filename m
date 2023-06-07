Return-Path: <bpf+bounces-1990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C71A725DBC
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 13:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618E32812F0
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 11:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFAC31EF7;
	Wed,  7 Jun 2023 11:55:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD128C3D
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 11:55:57 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5681BCC
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 04:55:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f62d93f38aso3879629e87.0
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 04:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686138945; x=1688730945;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NX7UaOO/Zy36F/I4Mlc9GyuSRdm8WjFUnFhZPx0ZM3s=;
        b=pYPQSOC0HGiz2kQMJUrmFmrQERXjZe9Z1UV5Pz75oj1FXbGbIIotOg1YjKPlipE2Jj
         OpfPChF6Nsh8uAeQsyEjuel0fd3QlUO3oDfNO6avIp3Nj6nwlayO520xEttlMiIljyXG
         Jjjj5i9RwokkigCT8RNFTE+Lh0i+RVlXVSxGKAD8+JjX89UrBUMy9nlOQwpQXEghJTLI
         3yFrzFxgKz/348eG4l3/zr2v7vx/u/gpkTZU/8DbBkBR3ty0fQwuSWFsjb5DPb2mJTdy
         s20IQQAlWvF0RFAbKU8osV/oCuCI50edMiyl31QNaxz3tj1xAW0sw7N4H59WurVOk2br
         dbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686138945; x=1688730945;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NX7UaOO/Zy36F/I4Mlc9GyuSRdm8WjFUnFhZPx0ZM3s=;
        b=csYpxS8AMlAbLtFRP4EY2/97O+LRcre1b4fviMBzON7xVrSC6r6hdofruROFDuFfM9
         ddgZ4rIBef2577tp2gtaGrgWCT8oHR94xPqJrYkgQF5O4crS4po9GZ525rJEwWOcv0EE
         n8fcOWU+6Wr75UgKMmHXH+VHC/ivZnD6/LYY99Jui3JJjnu5Y2HZdNm6TICphVIrTvT0
         kCx0Wx/zhXGceRzmDZO56Xhte4WdWhtEIKIc6urXLSA51WKd21Y/5QUbwwwI6zzLvP+h
         tjGnXaXmiOmKflButGAsHiTIYLkU0/7s57SRyWaOPScrTLQumsp7WThRgds1P9jK0UdB
         LNLg==
X-Gm-Message-State: AC+VfDzQNeubiTxrH06jqEiNiRDJTSoMJjHQegHDu/sl3IdKDkISDcz0
	q0t9+duFfy08eX7X0iJwchUujyqRj0HAng==
X-Google-Smtp-Source: ACHHUZ4UW+T59LnuZvLXcjhMeFnHavOVLzhgov4nxCeY0HJei3o9FDILUaJqC7QbcvPFLe1XuY7Oeg==
X-Received: by 2002:ac2:4c35:0:b0:4eb:1527:e2a7 with SMTP id u21-20020ac24c35000000b004eb1527e2a7mr1919571lfq.45.1686138944409;
        Wed, 07 Jun 2023 04:55:44 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l1-20020a19c201000000b004f3ab10016bsm1795898lfc.16.2023.06.07.04.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 04:55:43 -0700 (PDT)
Message-ID: <35e5f70bbe0890f875e0c24aff0453c25f018ea6.camel@gmail.com>
Subject: Re: [RFC bpf-next 1/8] btf: add kind metadata encoding to UAPI
From: Eduard Zingerman <eddyz87@gmail.com>
To: Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Quentin Monnet
 <quentin@isovalent.com>, Mykola Lysenko <mykolal@fb.com>, bpf
 <bpf@vger.kernel.org>
Date: Wed, 07 Jun 2023 14:55:42 +0300
In-Reply-To: <878rcw3k1o.fsf@toke.dk>
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
	 <20230531201936.1992188-2-alan.maguire@oracle.com>
	 <20230601035354.5u56fwuundu6m7v2@MacBook-Pro-8.local>
	 <89787945-c06c-1c41-655b-057c1a3d07dd@oracle.com>
	 <CAADnVQ+2ZuX00MSxAXWcXmyc-dqYtZvGqJ9KzJpstv183nbPEA@mail.gmail.com>
	 <CAEf4BzZaUEqYnyBs6OqX2_L_X=U4zjrKF9nPeyyKp7tRNVLMww@mail.gmail.com>
	 <CAADnVQKbmAHTHk5YsH-t42BRz16MvXdRBdFmc5HFyCPijX-oNg@mail.gmail.com>
	 <CAEf4BzamU4qTjrtoC_9zwx+DHyW26yq_HrevHw2ui-nqr6UF-g@mail.gmail.com>
	 <CAADnVQ+_YeLZ0kmF+QueH_xE10=b-4m_BMh_-rct6S8TbpL0hw@mail.gmail.com>
	 <CAEf4Bzbtptc9DUJ8peBU=xyrXxJFK5=rkr3gGRh05wwtnBZ==A@mail.gmail.com>
	 <CAADnVQJAmYgR91WKJ_Jif6c3ja=OAmkMXoUO9sTnmp-xmnbVJQ@mail.gmail.com>
	 <878rcw3k1o.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-06-06 at 13:30 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
[...]
>=20
> As for bumping the version number, I don't think it's a good idea to
> deliberately break compatibility this way unless it's absolutely
> necessary. With "absolutely necessary" meaning "things will break in
> subtle ways in any case, so it's better to make the breakage obvious".
> But it libbpf is not checking the version field anyway, that becomes
> kind of a moot point, as bumping it doesn't really gain us anything,
> then...

It seems to me that in terms of backward compatibility, the ability to
specify the size for each kind entry is more valuable than the
capability to add new BTF kinds:
- The former allows for extending kind records in
  a backward-compatible manner, such as adding a function address to
  BTF_KIND_FUNC.
- The latter is much more fragile. Types refer to each other,
  compatibility is already lost once a new "unknown" tag is introduced
  in a type chain.

However, changing the size of existing BTF kinds is itself a
backward-incompatible change. Therefore, a version bump may be
warranted in this regard.

