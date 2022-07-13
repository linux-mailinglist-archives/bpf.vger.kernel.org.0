Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6726480BD
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 11:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLIKO4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 05:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLIKOz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 05:14:55 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2026.outbound.protection.outlook.com [40.92.99.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5E12FC3B;
        Fri,  9 Dec 2022 02:14:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVLVlM7g67N/jhqoPrdbTFpgxUBZcMg4wTJiBA0S47HDiqwFPSch5rCM0bYuM84lD/lsl8DocalH7b8XJ1/cZPFYYVhu8tKDVMLUY9LO1RcZGj/des8qLqhoAIRz/ID6RxylJwqgurYd7IGHC2sxH+7LqKCDuAvC/S+8gwO1BE+rl2mY3/r9s8TCTkZSjZ8HBKfQ/ekH77WmZfQZBKTDupcV++BYVJlvUG7ArB+BBMVqA9UxT6tPbeQzGMoP+PbvP+1zvuC+guRPY+J8F+wJ2UMxcFB8wctTwTHsEt9YO1jMaFHC9Fw6xAv8EOkmyiTHtHJWR5El1MUdq4LDsexUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xUq5hWLotuxnaZ+21VRhBm4x/+4cOkHs15MDVDmIR0=;
 b=E7tcEtpfNe6HJyuSOdWo52BWa5GHETzMPo7QnV+74FG0+CYauHoAjE3P/vxKszm9B6lLTFFyCbnRsuD59sLF7slUb40u7L8d21gcj1ZZggsIB9AWKfyOAbay45NwwB7djPlHs3WugtF7+kfZ3ZWiV8Z1JA9d/SEGXMKYUCPc4g7pBYK/lIIi4yZDWW25kC8KyIrupiHo0jL6mdQHz9srCG9US0Y1rwu0Qktx0WKC7on3cb9vLdqSIYmkYGiSGJBiJHoSdOADGnxCc2+sZldxGr6j23+U0qx/uX51hUnz4SH9SOyNMCr6mokpIwLPzLWBOioBYOJq3149JslT6Sovsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xUq5hWLotuxnaZ+21VRhBm4x/+4cOkHs15MDVDmIR0=;
 b=ERLOqsEpRqo/GY+2rJUV0/tPHZn8lUpDldviNsUEh+M/lY26+Tn7owuAmQPUZer3UPYu33HXJzAbH8PLU8vtGzO2bC/6cVIC7a/U6h5arsvG3J5Z4+V0B8BQ2A6LuPU2IxbRei+mHdJO3WoTKG5iJwxvWijiPM8n2/3VXik3CIdRy8oQbKqie4tRwfb0FGmBc/NISXTokQtqX9mwXZ/FmCdqMWfHOMqX+KQlBbqXNvrdqodcMGkJhWgOaSXLC110XJPRceScdmUwZypPc1nRnGfaTTyVmwbEJrBntDeM655KhP+2NxPvVop0n4WerWrdDCh5bjIP6znhOp/DyOPlqA==
Received: from OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b9::12)
 by TYCP286MB1657.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 10:14:51 +0000
Received: from OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b6a5:6455:be00:4bfe]) by OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b6a5:6455:be00:4bfe%9]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 10:14:51 +0000
Message-ID: <OSZP286MB1725F414B934C820252578CEB81C9@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v2] libbpf: fix the name of a reused map
From:   Anquan Wu <leiqi96@hotmail.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Ys0xcf2yRG4fjkBY@krava>
References: <OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
         <Ys0xcf2yRG4fjkBY@krava>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 13 Jul 2022 13:44:48 +0800
User-Agent: Evolution 3.40.4-1ubuntu2 
Content-Transfer-Encoding: 8bit
X-TMN:  [1GyotuBjFXQatPy0sUyV1BLIDxM2Cdt5]
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1b9::12)
X-Microsoft-Original-Message-ID: <3875c689fb188258782a79b235493a2fdb7cee00.camel@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1725:EE_|TYCP286MB1657:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf85f74-120a-4649-7ed2-08dad9ce315a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00x+UQ0kiyGokgaBGp3bBf2gW64CTbNON1YAkOVdNYTRx2jh3kyLFEvDKZw1kI1L3vCq24NossO4E7JHk3xFJqalbpSZTn1dF3CcrSO9d7bDililsInEIjDOck7UgPjAN/BsxtznOrmairPcLx99qbMOaLZi4qaDHVcYKzBdZYyaDCXFx7JEs5X/g83eENPggl0bmacjmxmzxmLWYJr5T9N2i5yqlJilyHvcOOBYlilHeAaD3lpkhPsIQKCnheLuo4Bj0KaNYM1rg/mLngIXZN3PQegm/hHmtmw8yieSDSUfZIIy7tIHXCcBYCRNDCqXnYPapleEhQYNEDxuvw1ll/u8RKvIll4seDTy/PqAMrx5HlgaAjjvTanX1d5hMhjAMjAInGEJblON9iiOX8Cl68HjT86424dM+GGtlqvnd26paVOYxGRq8/kfX0CZoMuqU2gRe5b3EpNpVSK6r+x8elVNjK2wIzgIIbgDyp5tEtuWXCWz1CRvCETo0j3QjTLaZI1bg/0P+nMUh2s4vIgOZey8ETxCusmuulOhA+etpdU9aK3UNpd6K4OsvLosqij0HqAOa7is/J1PYrnMWl0+kcStVBHLEIDNzc1T1maU1w6HwtlnIN/uwPLzuHnKmPxYvpWlfr5BPYv1thYpAlyAY8rGMswH5xDfSviPXgjY4vzU5RtqQQQFvAigywUrd/Mp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3dNa1BoYTUyb0RJYU1UTVJ5YzVRUkdLNlFEemd1OFNsWHVNVS9OWHA5S2M4?=
 =?utf-8?B?alRPZEtBcXd4TTFiZ0ZlN0JEbEw1U2E2cHVrTW9YRTVHSEt4aXArU3FtWjdx?=
 =?utf-8?B?R1dHcm04U0o3THJHN3hCeG5YN0w4bWgyQ0Q1MkF3azRyNkNXM1hpSnFmc0tw?=
 =?utf-8?B?RUVRTis5ZWtUWFo2eVJ3M0luRnNLK0xsSGhweW1iZVBSaE1MR0lDdjVsYnc4?=
 =?utf-8?B?VXFYSVg4R3BvTUFIVGYvMVFVU0tMVkNIQ1QyaUVDZEZjTUN2bzFVSFdPVi9p?=
 =?utf-8?B?NENvMkhTNFNRZEV0MHI2VEVzTGUrTm5Xb0NGM1RSZ1lhZjAxL0pLUWVmd1Vz?=
 =?utf-8?B?SzBMYlJLZVNUNkVuR05xcENMN2MxM3FWamlYVU1ZWlAyVUdaaXN1N0djZlZl?=
 =?utf-8?B?ZnJBRGxuSVBndjh5VUZJc2ZVenN3YXdsVmQ3ZlJoMlQ1UCtObUhrV2tWVzR5?=
 =?utf-8?B?aUtnMHhjM2ZBTjAzN3pFVElreGdaOCtJOWlOd2l6RnVWMWVhWURCb0NJck1Z?=
 =?utf-8?B?ekRlZ1EzVFpuTG5iQWZwM2FKaHk1MTA5YzFZdnBZNzlPOE9LZTR4QVNCLzc2?=
 =?utf-8?B?bHhKSjF2RFpPbFBuZ251WWFwQzRtVkZmUXRNRUU2OFB2Z09KNHJ1NWs5eUQ4?=
 =?utf-8?B?ZUlhYnRtU1dYdm02a1ZqSSt1Q0RFTnZhY1NyV1RLWW15TnVQWmxFRWd1Wit6?=
 =?utf-8?B?UldDNXVWUlczOXhCUUFQR0ZpODFGblp1UjRyTmkvM0p4LzVVMVd3M0cvSE10?=
 =?utf-8?B?b2k2MWVuaStPays4Tys3OXZQdThyT2grbmY4OUdZdlRkUEp5Sm5reDFiMVov?=
 =?utf-8?B?eE1MbUxaVnZ5Q0o1L2FCZVFrRi90UUlKc250YzdqdVVVN3RNSy9uUmRIcDBx?=
 =?utf-8?B?Tm5YcTFHRmFvSGIzWnFVZWdtbXZoQWZ3MHBLdGhaY1djUm43THBGQjdJUXdF?=
 =?utf-8?B?TDNOVlluRWx6VkpqQUhNQ1JiM1JTN0p0L3Y0a2JvSTB4WktKNHc1am90SGdO?=
 =?utf-8?B?Nld4ZkZ3NzlTTUtWaDN0cEk4dkZpUFg4cUlVVnEyd1cwOUFpcGpoWXhSaytO?=
 =?utf-8?B?WEVIUTUyb0xhTkpvN2N1ckxaVXozZ1ptQzZVdVNMRUM2cGQ0TGxMOTkzUHlo?=
 =?utf-8?B?cFJESmJ1T0lBQ1hybCtIZmFocGNyZWlTbFo1c0xqQWdISUlGcml0TGRFOVFU?=
 =?utf-8?B?VnNrYXVLRS9Ha24xdTFMK1o2TktmeXVOejRNZnFTZlgvaktKc0JQT0tWL0N6?=
 =?utf-8?B?TDhqTEVqSC9nNmZxS1hsSzJTSTdzblF0U3loanIxdHdlTStzWU0wVmw1aTRt?=
 =?utf-8?B?aGkySGZyazN1M1FwTjNseDYxcERPeEd3QmZkNU1HcXlvWTdKdXZ4NkhIQWo5?=
 =?utf-8?B?TDdybUNiVDZqbnpiNVpqV1BmK0JFejdJb01kTzZIYmlvbFliZWh5RkordTY0?=
 =?utf-8?B?b0RqalUyaXJKMmgwMGZkZ1QwOGdRa09JVjc0Szc3VFNDMkdER2d6eGpNV0o1?=
 =?utf-8?B?Uy9QUDNlMklaKzZVOEdyQlp2WjNOSmpTMm1YWFU5czhOaGtMazVMTzFWMXBK?=
 =?utf-8?B?SXpDMkQyUjRWdVhiSHI1MlR4aWZsYy9Ha1paci9oSkFBaXBCTUZnYlFxaUYx?=
 =?utf-8?B?OW1GemJSdVVodk8vYy8vSXZIcXZuR1JGcDlDNTZZL254K0hjd0h0dGs1L1kz?=
 =?utf-8?B?Mjh4QkVGa0dDWHhJOTdoLzdhaFQ2MEtDN3JYOGpoVEE3c0pzUUZCRWZRPT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf85f74-120a-4649-7ed2-08dad9ce315a
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 10:14:50.6525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1657
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-07-12 at 10:31 +0200, Jiri Olsa wrote:
> On Tue, Jul 12, 2022 at 11:15:40AM +0800, Anquan Wu wrote:
> > BPF map name is limited to BPF_OBJ_NAME_LEN.
> > A map name is defined as being longer than BPF_OBJ_NAME_LEN,
> > it will be truncated to BPF_OBJ_NAME_LEN when a userspace program
> > calls libbpf to create the map. A pinned map also generates a path
> > in the /sys. If the previous program wanted to reuse the map，
> > it can not get bpf_map by name, because the name of the map is only
> > partially the same as the name which get from pinned path.
> > 
> > The syscall information below show that map name "process_pinned_map"
> > is truncated to "process_pinned_".
> > 
> >     bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/process_pinned_map",
> >     bpf_fd=0, file_flags=0}, 144) = -1 ENOENT (No such file or
> > directory)
> > 
> >     bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4,
> >     value_size=4,max_entries=1024, map_flags=0, inner_map_fd=0,
> >     map_name="process_pinned_",map_ifindex=0, btf_fd=3,
> > btf_key_type_id=6,
> >     btf_value_type_id=10,btf_vmlinux_value_type_id=0}, 72) = 4
> > 
> > This patch check that if the name of pinned map are the same as the
> > actual name for the first (BPF_OBJ_NAME_LEN - 1),
> > bpf map still uses the name which is included in bpf object.
> > 
> > Signed-off-by: Anquan Wu <leiqi96@hotmail.com>
> > ---
> > 
> > v2: compare against zero explicitly
> > 
> > v1:
> > https://lore.kernel.org/linux-kernel/OSZP286MB1725A2361FA2EE8432C4D5F4B8879@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM/
> > ---
> >  tools/lib/bpf/libbpf.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index e89cc9c885b3..7b4d3604dfb4 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -4328,6 +4328,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int
> > fd)
> >  {
> >         struct bpf_map_info info = {};
> >         __u32 len = sizeof(info);
> > +       __u32 name_len;
> >         int new_fd, err;
> >         char *new_name;
> >  
> > @@ -4337,7 +4338,12 @@ int bpf_map__reuse_fd(struct bpf_map *map, int
> > fd)
> >         if (err)
> >                 return libbpf_err(err);
> >  
> > -       new_name = strdup(info.name);
> > +       name_len = strlen(info.name);
> > +       if (name_len == BPF_OBJ_NAME_LEN - 1 && strncmp(map->name,
> > info.name, name_len) == 0)
> 
> so what if the map->name is different after 'name_len' ?
> 
> jirka
> 

If  A map name is defined as being longer than name_len (name_len is 
"BPF_OBJ_NAME_LEN - 1" in this context), a program will fail to get a
reused bpf_map by bpf_object__find_map_by_name().
   
   fromhttps://github.com/libbpf/libbpf/blob/master/src/libbpf.c#L9295,
   pos->name in bpf_object__find_map_by_name() is from  new_name in      
   bpf_map_reuse_fd(). It can not find map by the name which is defined
   in bpf object.

I wrote some code to verify this problem and test the solution
mentioned above.
Link: https://github.com/leiqi96/libbpf-fix

Anquan


> > +               new_name = strdup(map->name);
> > +       else
> > +               new_name = strdup(info.name);
> > +
> >         if (!new_name)
> >                 return libbpf_err(-errno);
> >  
> > -- 
> > 2.32.0
> > 


