Return-Path: <bpf+bounces-4867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D63751068
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 20:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA897281A31
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1FD20FB4;
	Wed, 12 Jul 2023 18:20:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CA14F7D
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 18:20:42 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F22173C;
	Wed, 12 Jul 2023 11:20:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so114756791fa.0;
        Wed, 12 Jul 2023 11:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689186040; x=1691778040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmzL+tJfYuaQRi+b/kypiwix9rmrgj487gAoOBBglmI=;
        b=JaMy/SVWGsojNIYOvqf0+SBKdpKdC/kVMQvKUoBHCsw3nkbEvV8xSWQL5/WrCQ0FwZ
         NZP7oGRPbxhmlBu2SA29QvGojJLFaBAuoaFRc+hcNBHZ1/OxYN9o/ReWNbVTZ4uLxuxa
         B4p1F7V2hgXH5qyP4kkPAo0HPn9bCa347FTHdWoLLwOH9h1Xhq2Daj0KN1L/V4tX/Yex
         U+MvT4okzCZ9Sc3d9TS+JLcIfSulleaKhPqwtEBYhRzwc3zgTsllC0MWIR1kLRwBeBtO
         Sf2kve5Fegw1RC5rOYCM2xeh+ddD8KTbCroWTxFUcP1DE+TOiImpXPQ/E17eZjynhC8O
         Xn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689186040; x=1691778040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmzL+tJfYuaQRi+b/kypiwix9rmrgj487gAoOBBglmI=;
        b=X06MWZEYG6P0jJ49IY3skA7BAewN2N0EPpWa8SkZf820/hRHjPiV8uqyV7SndI6oQQ
         MqNpjd150HLIjb+buUu1IKf8gy54GKn/tDz64d0p+fAdDDp/E4otBdLz4Vzn5yoJjuci
         FFnmnZmV/0OpVFM1FnIYMyXA1PRmnmr81oefwsPu/l1tJ+Akd2MirieRDqzfLcZzKvve
         6GCg7zOYT2zmSd04ZKBbOyFkFxDPkHE2G55UuEReBNwUArSEijCfvQNo8YqkXXaWGIEK
         ceZKoMqISQNLKns+4pvV+YSQFwPbiox8beqK7Ki6WneN2QVvPSj2ssjaZu+N/yHWDXPt
         yS4Q==
X-Gm-Message-State: ABy/qLbWgHU+uFemTL2smlufk5QQKxhIrGgtkPwA0mZae4UxwMayPe3L
	sGQPzNExHLAOsoWJbZ7vFw+897sTRfoRhP792Cw=
X-Google-Smtp-Source: APBJJlG1bJV6A2TAHRmW5wfhHWdt28HxYb8FlRr8dKOcN3MRPEdg2agk5OadUa6eF7fjc5hBfe0J1rOSoBzXfUvyyAE=
X-Received: by 2002:a2e:b0d1:0:b0:2b5:7f93:b3b0 with SMTP id
 g17-20020a2eb0d1000000b002b57f93b3b0mr16089265ljl.17.1689186039531; Wed, 12
 Jul 2023 11:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab865e6d-06c5-078e-e404-7f90686db50d@amd.com> <CAEf4BzZK=zm9PkUwzJRgeQ=KXjKOK9TENUMTz+_FmU6kPjab7Q@mail.gmail.com>
 <78044efc-98d7-cd49-d2b5-4c2abb16d6c9@amd.com> <CAEf4BzZCrDftNdNicuMS7NoF+hNiQEQwsH_-RMBh3Xxg+AQwiw@mail.gmail.com>
 <146e00be-98c8-873d-081f-252647b71b12@amd.com> <ZK7JMjN9LXTFEOvT@kernel.org>
In-Reply-To: <ZK7JMjN9LXTFEOvT@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Jul 2023 11:20:27 -0700
Message-ID: <CAADnVQLpfmJ7yg-QtwfOFATJb=JcSDDxo11JG32KOQ6K=sNp4Q@mail.gmail.com>
Subject: Re: [BUG] perf test: Regression because of d6e6286a12e7
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Manu Bretelle <chantra@meta.com>, 
	=?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	Mykola Lysenko <mykolal@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 8:39=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Right, perhaps the libbpf CI could try building perf, preferably with
> BUILD_BPF_SKEL=3D1, to enable these tools:


That would be great.
perf experts probably should do pull-req to bpf CI to enable that.
See slides:
http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-bpf-ci.pdf

"How to contribute?
Depending on what part of CI you are changing, you can create a pull reques=
t to
https://github.com/kernel-patches/vmtest/
https://github.com/libbpf/ci
"

