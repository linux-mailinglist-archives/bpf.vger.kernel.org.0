Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EFB5EDBB5
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 13:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiI1LZJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 07:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbiI1LZI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 07:25:08 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2165.outbound.protection.outlook.com [40.92.63.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774449FD2
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 04:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hni1HXf5ZFe2uMt/1qasSftgr/pdyOy7JSN+7iWK0Yco6YijgKq6Q9WahSlPH5ol9Io4mu3bXoaWG4DMLncdqbzm2JcaChPXIl7eiWg+biCMUHwXwX7oAjp4MHPOYNKDSewz5Hi3w9yfviGGfiKMnYM6ZKqpL0PU7QwfYzofXMRl8xCl1961QNn0twtTjQ1MnQ8Wi1SxDCL23377vDTgnytCtmsvtrMogH8dcNItYy8g4NDJObS1UbgRXsXc+Xr3MDivdRDYOWH4rInWr7cHqNLhCYIe1qsNc65VFb+p98F5q/3sHQMS8EWLseLcYk5aZjwdHpQ8Zyjsea6FHrrYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBvUa3vJUg90UiEsb00K0mxVkiXUq9AIMeKqVDiPVIk=;
 b=S+hr0Jqp0aPP0AL2+qk6KfohvONmjZMQKVc3LM8n3fFa9nxM4lZA+39rXICwKU2PmQ0XbQZhA4ZMsgiKB7qm7uuXi6EdmLaolE181tggjcqxrp9s6F1FXGwaV6imCSOa3/HqOo5/4ZbfPQmpTR2MiOJwZ4VeJsd9bITN1c//36CyKGPbBjISaAQEYnbS00ZFcSdEFq9JfyASI7D+gAMMUB3ljdSrqenayrr8qCW3GRyBjTOWOzzRLPYjUYzD6k0KUVoH4f4rV8SZolW5oKQYO5yp0X1MPwh6qZJ77z9Z9zrSR29Ej5+75FuRJEC/CyqtMZ1UbfQa+MvQTNkNmqAFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBvUa3vJUg90UiEsb00K0mxVkiXUq9AIMeKqVDiPVIk=;
 b=DburJDcAYhc9YKTCoRpTeJPKxOwHl86L1FstaEMi3f2RNpc0on9Xt+bvqDxJRXa70szQ20vznf6gYrga8ACdek7K8lwUrSwhG6jVjsoYCBEOhl07Fe7vtwrwBNbA9AGIQyNeh23wW1kY2a5zytLfOzG2Il73i1zpGps013E7Ru5WLHpcsRDk8xDLNEsIRInq7mFFDweAVEbBcKadG09T5UYAyxoq1In195XXAkMnp4CKwAJ2z/3WaeMizwOsmlW/akWIxOKLekCnFbXBgy3ikoJxlsNGxyc3h+W9tewVP7/xRVLJWEOfb+QXpnNoUTg87MitMHW/MZixV7AJPtIkZw==
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:ac::13) by
 ME3P282MB1571.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:a4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17; Wed, 28 Sep 2022 11:24:59 +0000
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::549a:65d7:eae8:3983]) by SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::549a:65d7:eae8:3983%7]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 11:24:59 +0000
From:   Tianyi Liu <i.pear@outlook.com>
To:     andrii.nakryiko@gmail.com
Cc:     andrii@kernel.org, bpf@vger.kernel.org, i.pear@outlook.com,
        trivial@kernel.org
Subject: Re: [PATCH] libbpf: Add friendly error prompt for missing .BTF section
Date:   Wed, 28 Sep 2022 19:23:12 +0800
Message-ID: <SY4P282MB10844F5E962746CC0C628DE39D549@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <CAEf4BzYbmi-NQ8qQuMmCWCG=0V2z4SuKogb4y-WrUKkL1iw7-w@mail.gmail.com>
References: <CAEf4BzYbmi-NQ8qQuMmCWCG=0V2z4SuKogb4y-WrUKkL1iw7-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [QpxMtf1YX01DJu5ZRWzCewLaR7dAdno027Cj6k5JuYri/s3oALR5kQ==]
X-ClientProxiedBy: PS2PR04CA0020.apcprd04.prod.outlook.com
 (2603:1096:300:55::32) To SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:ac::13)
X-Microsoft-Original-Message-ID: <20220928112312.1682345-1-i.pear@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1084:EE_|ME3P282MB1571:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a12f6d-675e-445b-0efb-08daa1441439
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3kh+Zs0i80maiFQsQns05WCW4edbzpsq1//dnGcMgAHlvR3ALtn5tfTadFlMWOq5b+DfNoG80sJePqC/V3L+DYrCJhLRK7xVCmefDstSvMCqpuSEq5QXJUVsL7inNegqsDVsphiQ0F4RqoKRF2720K4w2BpwXkH1RCabtK6aT685XWRDt8O+bgzoKPamOVbh+chVbourDW9vwprbCAQSD1WxI8a9E0H8ykDREu0ivKWXZ7svulAXPlSfw9oVtOxr5dj+U+5f02qoUBuO7jZ0eXEYxpeoGp83HYy4U0XbxNS/UDREVXGbDu3weDSmDBRtKqF8SDj6hjxAxQA070cA30j0E3IGUyahD/V8Ve9rOpoj0N8HJ5aCglxcAWAKmei2yclVcn+OwA//r7RFUcSB42HKCsC86XQPY0w3T+DzVIhGihHO11n0UqTy9Bkc/oFxxOi4hzsJE9rSQop3GODJahDC5rDNDRQUs8Zm7rEiV3etvId3axiBKgC0OVGcfmMZBqlqghXsY+B05gV8YLJtahGgBq4wO+m9mE92vWaZ7ocRPtOhvr736XmL5oQ9dE8xcBO+g0sDNG5WPlUQEhSqq40ztqWC0UyLj/WjZ/y4YLKOHsoONBIgilIrPsBnBVDUSlBWKPTaT3/LqcxdNV6ktfQWEXAVfTYBa0VAasOo5i54bCZthtFcN4izCZWM7Fj2RX0f1UpM4335wWSaWZOuAbK6vrnQGyDu7o5zbDXp+wDdpjgmLNl91WSCjj2FiSM0TuU4bODn+e+Ty5VgMpD6V8M
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: naolGFKma0bPKUc+U8uGyfbcG6TaFm/IYKEyRnJml1+5UQwrDSPPIbvkB7tiIEgpsL0IwLN2T9afVeGQkxHxiHrAOFfwbdTbVaBwUQ0Tqpt0c2Oy9wV1p9DaJyAXm4dFaHFxLQXMOUqfDxPuWcmdHBqjfXDBi5tzT9S1niOsWPLpaFURqS5Y0Sou4hts/rzmXpdROLn+Z4285vQVWuaIJ75LB9nNAAjvfwGJJf6xs09uO4WVSaWXAxhhSGYB7mpeeSdV4zHvIEwhrWA+D+4Cix0Pkm4t40PV9xNXh3G/mb2+2Vb4PMScg3qryaPsP5930Ckj0csMqXRjQT+nrqC0kBZ2cqAc4Yh8io/lswMhOm+jKGeczpwSjOzeQ4KmQ42d9s1oWgdrIQRTgsM4h4AD6tUuVY2JwXFutL4CIRfBvm66/i/B4CJN/YsxEzHN4RMLGSx/qenceWvX3aqGjhkb+PjwcrKt/32QVjHD6m7OKYkj4viIWXfMmT3BuhgDe382h3AA6hfdWoc/tu4Nf+flzYw8dflxaMLb3DJGSfeMn3wSArX1UWm5iXH3adKCHWCXEnroM2N4tIySF8nYhKzt6KfHxiKkku7l9Rxjxx4Eo+XRM8sPzwXgBJq0pVnM9IaiNBhCnegTXWVIPzRI9KxIeIsn54EcevIHMleUXOezFzrXnhhsnUt3RGrtQqsvkwn4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3JsaTUrY3liZjFlT3RFanR2UFdqZmE0N2ZDT3Rib004TWcxbzZuS1dVV2hX?=
 =?utf-8?B?WStPUHVGaXdZWFdKcUF2bXZSamNkMWJGQURSeFZNOS9wV0NBM1pRS08yQ2JW?=
 =?utf-8?B?dU5KZzZsVFpVNmNlREdSVXhIbEdpUnlHUlowcWl2aE55cUpGNEl3VmVSMFZL?=
 =?utf-8?B?ZUF1VW1xNmwxU2VETXRxakF2dWllWFFuZXdjQmFrZ21uQ3ZIdnR0L21saFVv?=
 =?utf-8?B?ckVxZVUxNGtENGdRQkFOUjB3d1p1YW5jRy9PUkR6eHlXLzJGaFZJRFVvWnkv?=
 =?utf-8?B?a1NHcisveExBTkthKzEzRlYvb0gzNjhyWVZaOC9EdGhxdFdQR0lqa1NJMFQx?=
 =?utf-8?B?MUZQa0pkeHppSDRROE1iU0JmcnhRbTI3L3VseFVOd1NmU2pNem0wMWhmRHQz?=
 =?utf-8?B?QjhEdG9DZ25zNy9Oc29DaHJrdHRSSUc4ektnZzduWWZqZHNrYzhiNmlKbVVW?=
 =?utf-8?B?eDVsUXFXMmhGNnlYbldJcnArWVZTNUsyOTJNMXdSeVBJamNBbysvTmkwYmNR?=
 =?utf-8?B?cHA3ZnVEK2tNdU1XTWVkNkJRQ3RtRXByYzZwZWVwQkxWcnBtclYzNWN4RDZE?=
 =?utf-8?B?VzQzY0ZGaGQ5TXNYR3dDeGowTkNkODBWUzJoa3R0RjdJNFM3SUZjQWV2aFF0?=
 =?utf-8?B?aXlHbHFVUnpoNm1UTVFRVmdVVW00NEludXpuTUdxLzVqdlVvQmVIK29ZNU1G?=
 =?utf-8?B?a1RmNjhRbHY1ck5KSlRuaXl2bjc5a0xIeG1BOVpHRmZBaEUvM3F0eDBZbFN1?=
 =?utf-8?B?cXcyOTBWVUViRVR4a2RvWlU0UVc2UXp3NU43b3dxTGJtcGRuN2YwVnVJWUdt?=
 =?utf-8?B?citQUVFoejdMaHBaK241dVpDdmhuMUlZMEdkSnNZVEE1VUt2RFVqUzdJajRP?=
 =?utf-8?B?NjBJYXpCTzJHSFhmSDlJK3VqTlAxSzJaczU3QTRLU1huSDlTMVdZcG0yVG8x?=
 =?utf-8?B?cXdDZmV6WER0Vm5tRy9lYVhRdCs3V01tbW9IaVl0OUpycWUwWnBicTQrYlhy?=
 =?utf-8?B?QjdXQVRHMExzVWFvY2lMRHFiUGtkTldnV2VaaHlMN0RjZHhvUkl1L2RSNjhs?=
 =?utf-8?B?YW9oNjhtTVUrK1VUUjFKWmJMdVR5UGJYVzFRQzd3YXd6akV2Q2NPUWlWR3Jm?=
 =?utf-8?B?WlRXUWZycHZzNFp0eDlabFJxK0tVaDFOZnIrMUtETkJIeDZLSXFtTzE2Tkc1?=
 =?utf-8?B?WXFOVWZ1My9NOFViVElUTGxkVkpaaFpaMnBTVmZlWmwxdmc4aGkwR1ozU3Zr?=
 =?utf-8?B?SEE0L0g3c0FuNGwyZUlXOHYzekxQRGRlYStaMU0zQjc5bG1OdmpMYWF1UEtv?=
 =?utf-8?B?QjdSV1dzdXFxZXNkMW9hbVgwMHhlN25QOUgyQ0o0UldjNTkydWN0dGlTcXJi?=
 =?utf-8?B?WmVSZSt2L3hLNlBaUEF5VTcxY3F4SEZBNERSYTlaRUNoa0RITCs4THRhRGpB?=
 =?utf-8?B?cW9lZm1tTGZFRk8ybmMrMXZUUzgyT1BIa0pIOW51TjFyRG15aUNWZXB6TXRT?=
 =?utf-8?B?MGlLa053Zk1OTTdPQ0ZNMEZoczhqdVFONXVTS3lscmhNMkpwOWdXTFNSdGhp?=
 =?utf-8?B?T1JRajJJK2t5Ylo1Y2VHdmoxV3JlakMyVkQ2eFpMTEFOZ3FLKzltaU5ESno0?=
 =?utf-8?B?eEkrU21aYUNsaVNiUUYwSGdoUm91aFFqOHY1bmZrV1Bmb0F6dGgwSXVmdzRz?=
 =?utf-8?B?R09BdmllSGtCcW00WiswSmN6R2tDcEpKT3JGd3U0alE0c1pMRGhFR2p3MnF1?=
 =?utf-8?Q?0N+YIsd/vvqJd0j68U=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a12f6d-675e-445b-0efb-08daa1441439
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 11:24:59.7664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1571
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> -----Original Messages-----
> From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Date: Tuesday, September 27, 2022 at 12:37
> To: Tianyi Liu <i.pear@outlook.com>
> Cc: andrii@kernel.org <andrii@kernel.org>, bpf@vger.kernel.org <bpf@vger.kernel.org>, trivial@kernel.org <trivial@kernel.org>
> Subject: Re: [PATCH] libbpf: Add friendly error prompt for missing .BTF section
> On Sun, Sep 25, 2022 at 10:54 PM Tianyi Liu <i.pear@outlook.com> wrote:
> >
> > Fresh users usually forget to turn on BTF generating flags compiling
> > kernels, and will receive a confusing error "No such file or directory"
> > (from return value ENOENT) with command "bpftool btf dump file vmlinux".
> >
> > Hope this can help them find the mistake.
> >
> > Signed-off-by: Tianyi Liu <i.pear@outlook.com>
> > ---
> >  tools/lib/bpf/btf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 2d14f1a52..9fbae1f3d 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -990,6 +990,8 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
> >         err = 0;
> >
> >         if (!btf_data) {
> > +               pr_warn("Failed to get section %s from ELF %s, check CONFIG_DEBUG_INFO_BTF if compiling kernel\n",
> > +                       BTF_ELF_SEC, path);
> 
> This is going to be very confusing for any user trying to load BTF
> from some other ELF file. If we want to add such helpful suggestion
> (and even then it's a bit of a hit and miss, as not every passed in
> file is supposed to be vmlinux kernel image), it should be done in
> bpftool proper.
> 
> >                 err = -ENOENT;
> >                 goto done;
> >         }
> > --
> > 2.37.3
> >

Hi Andrii :
I agree with you, I will try to implement it in bpftool.

But there’s another problem here, in btf_parse_elf() from tools/lib/bpf/btf.c:
If the path does not exist, open() assigns ENOENT to errno, and btf_parse_elf()
returns -ENOENT. Besides, if .BTF section can not be found in the ELF file,
btf_parse_elf() also returns -ENOENT, the same as above. So we can't determine
which kind of error it is from the outside.

Could we change the err code in the second case to make it clearer, Such as
changing ENOENT to EPROTO / adding a new error code? Or we can just warn
that .BTF section does not exist.

Thanks.

