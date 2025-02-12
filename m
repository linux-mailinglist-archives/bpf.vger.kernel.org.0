Return-Path: <bpf+bounces-51197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EACA31B1D
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 02:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEA8164C71
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 01:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBDA2557C;
	Wed, 12 Feb 2025 01:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Nq2NDjg4"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FBE271803;
	Wed, 12 Feb 2025 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739323169; cv=none; b=jirNspIztQAeajnxpjPckcSrp2HArivbdep2VQonnYdOkrEPxdR/8RtV644Ebgn7FkSDpLmHfdOGJOocnVJGl0KJjCEFtyB7iRrcgWHMVZ72DOtPByxfPpMCc1e3U2bg8PwTJkoNxB84/r5W3xm2PRLdOlhGHa1rEV0E0sr75Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739323169; c=relaxed/simple;
	bh=00zxJ3OFKXToMMcCuMIfZzcplQ6YpZ85EzkT0CxoDFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJaZM1pngCZEuqclPCOeWbcAQKdBUchtY1hg6TDNW8K8TC5aEBA/uWCSkw7pvjIZW7WZbXrDxisHwz/z1ROygZl/INyr/LY+9veQuYNbfzlhQsTK3t1ZHUw1mmAvnoKCBSW1OMQ4votX0ybtHYTgmkrLjVF/goOLXGt/L07sLZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Nq2NDjg4; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1739322858;
	bh=hkb5PS5uy89LOmO5lpAIKqRbORJKhvE6tJPoRlunrBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Nq2NDjg4RjFgzYjuz5OzPQmzyQstnxULBvQf/9jeJjimn+nEc0LP7Hi88bqrRGBQR
	 CD9+9BUCgCxOJtcSe/cknbQX5qlH/vLSQ92gY+PkMBpG1DQgrFvf8/5DfSnrw1MqK2
	 nTDEU1M19WrEs9G7StPVOXrx3ZBSkM8kWoJCyl8I=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id 38E8387D; Wed, 12 Feb 2025 09:14:14 +0800
X-QQ-mid: xmsmtpt1739322854t55ojl0m7
Message-ID: <tencent_A7CAD02BDAA81222B6C184105ED6F9258706@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69mMwsQ4jG/8PoGIMZFthipSV6cS1FfTROqcMWpro5qzgaW3UV/l
	 jqpdyxZn6JoEfvcfN9WYVMwMQJuRqZ6p6wkW0VgZR/hLt06ugc4RylVrjR7rFnXDdCKXmIA/UQMR
	 fRopFrH1pqh0BE33ok17bELBjfQ5r5v+PhwDKmrwd+f0XVGS964Dim8dszc1FNtsdHA0sUITD3ZF
	 zbj1H3UZFeYuIZDdE+woNEGQI2ZUrqRjgfegJti+iayjFIPBKJO/dnR//jblQYHO+JpdM0h5os+z
	 GhoVWsX227jxGGZeqs6OCDRv5TyEkprlPMF2hVhVvgyUlTEIy38FlseQvvPXRlWz3WSHrHH6DC8S
	 KUPvw9PVKm/kAhG8TQ+vcZagH1wKXvUe1Voi4FNRk9YPsu02/kmzcm3OSYHoX+VPtvSuIZ3XGFb2
	 vawJjXYYUbdGzK41qfL/fEJgBkIIKosd6TOt7q5JWdD+I5nAZJ9E/vhqsFNU8PKNKXYuqup+QNfh
	 P5+541aptDKeVSZ8IpDjNB3Xsp6KGC48oPO4+cSpl9z183G5S12eIkUmc9b+lRFHwnHKMOQIngm2
	 Lm/GQ/DYmCc00pBWjbMW9BABIJncFVD7EyfnbjySReWTqOC/uKbUVdzhxrgO1z//pVAAqb8RMVEv
	 JxQ+voRoxkhw6uagGcR9u6/Pg/btXIEKu3qhu8vdHugHB8ISxmITXkrgfSRT4lKKoYRDn0/EeIQ/
	 RPKDMP2gs17d+W5PMtyqPMvhyQI/ZebI3Rj5InlXu3aZWTstzC4PmIjfR8P5mQo7ziDf8gOSr5FX
	 ow9r3jU/Xdlg+Rt5G5xGUDDTHbPlTny9mGu8A7u5wuIVOREWl7twttcvFbSzVCIZI+b4zAW+inSu
	 BzhGn/h0w6ktQKnllFbDZKizuaGZQASx7Iudk5LFzw+j7DUdGdImoBSArSiDszJn3P1c0p1kIgbU
	 7crqMZGQCYk3zT0nyFQw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-OQ-MSGID: <0b9a0335-8118-4e42-aacc-64c3182f670d@foxmail.com>
Date: Wed, 12 Feb 2025 09:14:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Check map name length when map
 create
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, rongtao@cestc.cn,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 "open list:BPF [TOOLING] (bpftool)" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <tencent_26592A2BAF08A3A688A50600421559929708@qq.com>
 <c886e85d-4c24-4a01-b04f-1006dbb7b512@kernel.org>
 <CAEf4Bzb9qWbF=H0L7ZF+nfztH8KkkfBJL00XgaKCeNpj25o7xA@mail.gmail.com>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <CAEf4Bzb9qWbF=H0L7ZF+nfztH8KkkfBJL00XgaKCeNpj25o7xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/12/25 05:07, Andrii Nakryiko wrote:
> On Tue, Feb 11, 2025 at 2:48 AM Quentin Monnet <qmo@kernel.org> wrote:
>> 2025-02-11 18:38 UTC+0800 ~ Rong Tao <rtoax@foxmail.com>
>>> From: Rong Tao <rongtao@cestc.cn>
>>>
>>> The size of struct bpf_map::name is BPF_OBJ_NAME_LEN (16).
>>>
>>> bpf(2) {
>>>    map_create() {
>>>      bpf_obj_name_cpy(map->name, attr->map_name, sizeof(attr->map_name));
>>>    }
>>> }
>>>
>>> When specifying a map name using bpftool map create name, no error is
>>> reported if the name length is greater than 15.
>>>
>>>      $ sudo bpftool map create /sys/fs/bpf/12345678901234567890 \
>>>          type array key 4 value 4 entries 5 name 12345678901234567890
>>>
>>> Users will think that 12345678901234567890 is legal, but this name cannot
>>> be used to index a map.
>>>
>>>      $ sudo bpftool map show name 12345678901234567890
>>>      Error: can't parse name
>>>
>>>      $ sudo bpftool map show
>>>      ...
>>>      1249: array  name 123456789012345  flags 0x0
>>>        key 4B  value 4B  max_entries 5  memlock 304B
>>>
>>>      $ sudo bpftool map show name 123456789012345
>>>      1249: array  name 123456789012345  flags 0x0
>>>        key 4B  value 4B  max_entries 5  memlock 304B
>>>
>>> The map name provided in the command line is truncated, but no error is
>>> reported. This submission checks the length of the map name.
>>>
>>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>>
>> Reviewed-by: Quentin Monnet <qmo@kernel.org>
>>
> Would it make sense to just warn but proceed with a truncated name?
> libbpf truncates the name when creating a map, but preserves the
> original name in BTF (and in memory, fetchable through
> bpf_map__name()). So from the user's perspective that map is still
> named "blah-blah-something-long", even if the kernel records just a
> prefix of that.
>
> Basically, instead of forcing users to count the first 15 characters,
> warn, but do the right thing anyways?

Yes, you're right, i'll submit v3.

Rong Tao

>
>> Thank you!


