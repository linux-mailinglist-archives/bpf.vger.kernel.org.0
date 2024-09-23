Return-Path: <bpf+bounces-40206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093297ECD5
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 16:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14391F2222A
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DE319D06A;
	Mon, 23 Sep 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVhPECaM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D3319CC15;
	Mon, 23 Sep 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727100422; cv=none; b=BFBPwG598pq0nkMKBMhRN6OEnqhQ6509nGzFkANvqSy6z/A+5JmXOr2SWA3PJ0zVyZzFjiWrTSg36MpmuKVVLhrra/Jy7Rvj1PihOfz1hK+f5Xgds+qybX4k5y+QkRGvdTvjdaRO37NXfFhb5UQvzQnAeGPe1LLukupxQC8y0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727100422; c=relaxed/simple;
	bh=kAhkFOZRzpqpdAPuuKV5YZkv/119rUuKLhWUmcZLwCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7C+0SDV3qDejlUH6B1DxKYXKgCVKUzm5AVSR8/xSHVp8AEFWnvwz8f4elpdgeGGRUfym0FdPmp4RnK4AFINGxsN8glz0OBlidIHbDvEe13j3N3fWqJOL4Bq7A67wq/sILSflZZdLjrJ7pw0SiyTf2Fin9/UE5xUbId+lkeWH0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVhPECaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4667C4CEC4;
	Mon, 23 Sep 2024 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727100422;
	bh=kAhkFOZRzpqpdAPuuKV5YZkv/119rUuKLhWUmcZLwCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZVhPECaMceyeaFxgYxfHSJDrWpi3BtHICiUSQ+8mosAzrH3pxFeM+TfPMtR/wxPMC
	 7exCHZPOJ4JF6i7H7OQEh6LwpJOMmrLkXpM1IqK5U24GtPKxar0DrhNOGprBKRVf19
	 WlzbpOWKcTUXgYpMjWLEgP3o5BaizCH8BkT+9UZ1+81uVGPDvCo8F+/qBJD0BWt2p7
	 +mZ0+fZA62i63cc3oYQwfvmYgLTW+EaWD6z5FC93AYzW1aeEDxX7LZC1Lv3RSbnCHQ
	 umu0McA3VJZCd8z7LaKhumGi84S9qzSmyudsZ3VR8QzAAsD1ZSSfhrByAENfcrGPFR
	 ZnVfwTCNnOlog==
Message-ID: <42b347ec-df8e-44b8-ba19-150ebaf04771@kernel.org>
Date: Mon, 23 Sep 2024 17:06:55 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/6] net: ethernet: ti: cpsw_ale: use
 regfields for number of Entries and Policers
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Julien Panis <jpanis@baylibre.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Joe Damato <jdamato@fastly.com>, srk@ti.com,
 vigneshr@ti.com, danishanwar@ti.com, pekka Varis <p-varis@ti.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, bpf@vger.kernel.org
References: <20240910-am65-cpsw-multi-rx-v4-0-077fa6403043@kernel.org>
 <20240910-am65-cpsw-multi-rx-v4-3-077fa6403043@kernel.org>
 <CAMuHMdUf-tKRDzkz2_m8qdFTFutefddU0NTratVrEjRTzA3yQQ@mail.gmail.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <CAMuHMdUf-tKRDzkz2_m8qdFTFutefddU0NTratVrEjRTzA3yQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geert,

On 23/09/2024 16:41, Geert Uytterhoeven wrote:
> Hi Roger,
> 
> On Tue, Sep 10, 2024 at 11:25 AM Roger Quadros <rogerq@kernel.org> wrote:
>> Use regfields for number of ALE Entries and Policers.
>>
>> The variants that support Policers/Classifiers have the number
>> of policers encoded in the ALE_STATUS register.
>>
>> Use that and show the number of Policers in the ALE info message.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>> ---
>> Changelog:
>> v4:
>> - reverse Xmas tree declaration order fixes
> 
> Thanks for your patch, which is now commit 11cbcfeaa79e5c76 ("net:
> ethernet: ti: cpsw_ale: use regfields for number of Entries
> and Policers").
> 
> This is causing the following warning on BeagleBone Black:
> 
>     WARNING: CPU: 0 PID: 34 at drivers/base/regmap/regmap.c:1208
> devm_regmap_field_alloc+0xac/0xc8
>     invalid empty mask defined
>     CPU: 0 UID: 0 PID: 34 Comm: kworker/u4:3 Not tainted
> 6.11.0-rc7-boneblack-01443-g11cbcfeaa79e #152
>     Hardware name: Generic AM33XX (Flattened Device Tree)
>     Workqueue: events_unbound deferred_probe_work_func
>     Call trace:
>      unwind_backtrace from show_stack+0x10/0x14
>      show_stack from dump_stack_lvl+0x68/0x88
>      dump_stack_lvl from __warn+0x6c/0x1a8
>      __warn from warn_slowpath_fmt+0x1bc/0x1d0
>      warn_slowpath_fmt from devm_regmap_field_alloc+0xac/0xc8
>      devm_regmap_field_alloc from cpsw_ale_create+0x10c/0x36c
>      cpsw_ale_create from cpsw_init_common+0x1fc/0x310
> 
>> --- a/drivers/net/ethernet/ti/cpsw_ale.c
>> +++ b/drivers/net/ethernet/ti/cpsw_ale.c
>> @@ -1303,6 +1303,9 @@ static const struct reg_field ale_fields_cpsw_nu[] = {
>>         /* CPSW_ALE_IDVER_REG */
>>         [MINOR_VER]     = REG_FIELD(ALE_IDVER, 0, 7),
>>         [MAJOR_VER]     = REG_FIELD(ALE_IDVER, 8, 10),
>> +       /* CPSW_ALE_STATUS_REG */
>> +       [ALE_ENTRIES]   = REG_FIELD(ALE_STATUS, 0, 7),
>> +       [ALE_POLICERS]  = REG_FIELD(ALE_STATUS, 8, 15),
> 
> You are adding these entries only to ale_fields_cpsw_nu[], not
> to ale_fields_cpsw[], while cpsw_ale_regfield_init() loops over
> ALE_FIELDS_MAX entries, whether they are valid or not:
> 
>     static int cpsw_ale_regfield_init(struct cpsw_ale *ale)
>     {
>             const struct reg_field *reg_fields = ale->params.reg_fields;
>             struct device *dev = ale->params.dev;
>             struct regmap *regmap = ale->regmap;
>             int i;
> 
>             for (i = 0; i < ALE_FIELDS_MAX; i++) {
>                     ale->fields[i] = devm_regmap_field_alloc(dev, regmap,
>                                                              reg_fields[i]);
> 
>                     [...]
>             }
> 
>             return 0;
>     }
> 
> I tried fixing this by skipping entries where all of .reg, .lsb,
> and .msb are zero, but that doesn't work as that runs beyond the
> end of ale_fields_cpsw[], thus operating on random data.
> I think you do have to store the size of the array, instead of assuming
> ALE_FIELDS_MAX entries everywhere.

Thanks for the report and suggestion. I will send a fix soon.

> 
>> --- a/drivers/net/ethernet/ti/cpsw_ale.h
>> +++ b/drivers/net/ethernet/ti/cpsw_ale.h
>> @@ -33,6 +34,8 @@ struct regmap;
>>  enum ale_fields {
>>         MINOR_VER,
>>         MAJOR_VER,
>> +       ALE_ENTRIES,
>> +       ALE_POLICERS,
>>         /* terminator */
>>         ALE_FIELDS_MAX,
>>  };
>>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

-- 
cheers,
-roger

