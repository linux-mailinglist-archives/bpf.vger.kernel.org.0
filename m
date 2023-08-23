Return-Path: <bpf+bounces-8412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7B2786103
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 21:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7DC2813B0
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509E51FB54;
	Wed, 23 Aug 2023 19:50:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612A1F945;
	Wed, 23 Aug 2023 19:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2F4C433C7;
	Wed, 23 Aug 2023 19:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692820248;
	bh=xUP8Aao2vUba1hN7Bnt0t6crXDnohGolTg985mKMKdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZuhIPkP4CUsDGiKsOw1+HxLQGXZ3YTAWFNprtH9vVrl5/Qw4zQzzpc7LN2Uhe5P38
	 n4sJnMcOKXZ4Dibb3GYiZ3x4yZQ+CeXJAGdmE0Mfn6c4zlb0rDzr776/rHhnqXomT8
	 PGx1H4DfgF/ul1OhKJMwWUU5Jbpleqxx5Gaf+hz1aK5uBsEgOtC8jXcv0wB+ML4SyI
	 qXmVdf9SyuWd/eEn4r3IRVOdEKtPAFjtomQu/7QpHHxi2trZDJ5eBjXndUBPWy/YBD
	 GD1MeLqAXSE5rpWrQuf6M2UjBwScWXM6ITjebQ9eG1Bjdwex2rcUUa2NgU8UNnuDeH
	 bTE7/+NhO2eUA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, linux-riscv
 <linux-riscv@lists.infradead.org>, bpf <bpf@vger.kernel.org>, Network
 Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Xu Kuohai
 <xukuohai@huawei.com>, Puranjay Mohan <puranjay12@gmail.com>, Pu Lehui
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Enable cpu v4 tests for RV64
In-Reply-To: <CAADnVQLu5twbe_UpiJrD0wKq1YyHzZbfzYhsW-mte7vDmyna5g@mail.gmail.com>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-8-pulehui@huaweicloud.com>
 <87zg2hk44i.fsf@all.your.base.are.belong.to.us>
 <CAADnVQLu5twbe_UpiJrD0wKq1YyHzZbfzYhsW-mte7vDmyna5g@mail.gmail.com>
Date: Wed, 23 Aug 2023 21:50:44 +0200
Message-ID: <875y55tu5n.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Aug 23, 2023 at 11:25=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@ker=
nel.org> wrote:
>>
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>
>> > From: Pu Lehui <pulehui@huawei.com>
>> >
>> > Enable cpu v4 tests for RV64, and the relevant tests have passed.
>> >
>> > Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>
>> Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>
> Bjorn,
>
> Thanks a lot for the quick review!
> Could you give it a spin as well and hopefully add Tested-by ?
>
> We still have time to get it into bpf-next for the upcoming merge window.

I'll kick a run! But I'd like a change to mov 8/16b patch (#3) prior
pulling.

> We still have time to get it into bpf-next for the upcoming merge window.

@Lehui Do you have time to cook a v2?


Bj=C3=B6rn

