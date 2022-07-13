Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E84E572DCE
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 07:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiGMF7r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 01:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiGMF7q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 01:59:46 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2057.outbound.protection.outlook.com [40.92.99.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54045004D;
        Tue, 12 Jul 2022 22:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfYfIu163HRdMiYqZ+V5zcAjdwbUN2HTmMXxJOxQl43uSIBOA9MbfOdVyMibggM6dNjLMTHSfSb6/pSp+fcyucL64XuutNBC9INf2ud1hvMjE4nwmqaTvNZqKCpK69hMxSShDI9L4JivPaOuK5gNMrLk+JkvSy1jChpWMIrZnDUMsaGwdsbqOcd3zu+SVMzJYmDXBuCowqEVeyPBM+MkzKbEq8vjMemkrE5lARczgqg4MLSSp6YCeF1Dy3vlV/3Bb/NVKp44/8fZh1AUk82m/vQUXI2nrjXEeKO2NAWbzv8Iegndi3HHj35mC60WF/hon7QIqJs4VAHixi1IApyJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPy3Eoy+X4lU7Kn9ow8KPehVfgPt+vVKjjaFLok9OAk=;
 b=bqT556oAdy0IGay7jSus+/Su4fm5tOCxXqhNNeQgx7FcW0U+736RbAF4FpiJTmCEi8bsW/0x3KWIo3tZ9tQlvbt8bw9UY2kZ51ZoX/VDwQvN3avEL/JXM0003SO7Tbl/GqFpEOgcWeinetzhasLeRwUBXQNWoG1nJlJyob38l724bd525cxcbK1vp/POEzEkdvBN0e+Fh4BXJGSgSFOLFB4kO5KOPO7WLVY7UxO2w/8bL57IOgkX0L00wl/zc6XNcmrltvVus5YlH1nkE/AsCDPkPcbU3gDTOWwMYzaHpfD3wHaQSLM4D47NQS0Cfnd6qvehJROQDiCDxVmyGhw/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPy3Eoy+X4lU7Kn9ow8KPehVfgPt+vVKjjaFLok9OAk=;
 b=NUebSj3kraGexcmeHLGRSaMUhu2Mt+S/OrVJ1Vm8I47lJC5875EYMkoOk2sIZPPC7GlR6l5GODarGKBXio51kTzzmq0hMMDKWbMjjjWYZ7wkvYIR0/fFHcZD6wQBPdj3KCy1dDTNQPrMgU7fsIxL5T1rnZb3YYbpkNyaG3q8u7von0n6GTy++TWGEixBqb+27H14MJTCuvrvJWYEOnegnVaWjEqLn00klxnfIvrxOmBmM/e+Lbxr2R0sD1mS6WKR3xjByigmWKnfJ7vw+Gs7+v2w+MFSvxZLOpUt7qpElXnSJIHoE4VfkXHTgloAV7zTlaxXiEyr931UkCb9ZkiPhw==
Received: from OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b9::12)
 by OS3P286MB1073.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:109::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 05:59:43 +0000
Received: from OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5999:44e0:89f9:487d]) by OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5999:44e0:89f9:487d%9]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 05:59:43 +0000
Message-ID: <OSZP286MB1725CD3371AEC94272D9CD48B8899@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v2] libbpf: fix the name of a reused map
From:   Anquan Wu <leiqi96@hotmail.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 13 Jul 2022 13:59:06 +0800
In-Reply-To: <Ys0xcf2yRG4fjkBY@krava>
References: <OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
         <Ys0xcf2yRG4fjkBY@krava>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
Content-Transfer-Encoding: 8bit
X-TMN:  [7K2n+7YutRwhDZ+juH20htS+h2WOovjq]
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1b9::12)
X-Microsoft-Original-Message-ID: <9f08efd54f7a2e06df1f36cd2b00657bd4b594af.camel@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff3ab157-be84-43a2-b4b7-08da6494e11a
X-MS-TrafficTypeDiagnostic: OS3P286MB1073:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cmUhIeB95eR9reJM4sAUzoTBD9VbM2KrxydX2/o7vyMq3SMTNP+1rluBfRP9lrSywORWDSqIiaP0e4mbO1aKuRTvtKqaB16tr6YfYR4uh+HaTZC8DegJLrrZXzWtZgezNSOkBvjz4vp9NmGPx48M0AIi6ZBfMj0XlUPRK+vwDxNYObPRLUaK/MH7D5YMRmOQOE4D2znYeWvqny8+Wf/73DWtwPTP5OHw56ltkLIllX252R5b3xl/gsgW+NHKXoATqFZKrWol49haoOAX3PSdKvwfsWzmOCRDue7NVeRMuFMSB7rTQ0Te28uskqAYy1ILMpzp/zqeUHOCbgmCeDP+HjjtvEAtuQJPPBc2XIUlXx9HhJ1w4mmQhlvjcJdSwGKSaFRYnT/nv32dtmuZP4X7Z7upom/cdqlP5LpnifxfR8tTGRoN8SeKR7KwJpe9aLYLMLdtHbcVcW8BP1BrB8rj8BIPwBpycc8xlt+cx3yXNCQOBTYz5bq37cwNHVsgj4MOQgrUltwmQ4s2F4eZSf0AdRm68AJCqnQ8KLrKHA8jrNU9Cb0pvG7MOEzqs+qjvckp7xSN1FytWIY04aGcbjA2mmOnBcf85reD81hY3BviFpGxBOEtqpGZPiMn0mYUVi75aOQy71mVjwlg0MqEODnysSYneFt0hmkO88GTOF3CIMYZz+ZNZrxVwvuw2xBqY94aY7bMmKE25VU0toPSjE+V+T93RNRGsPaXPh+OpaM+NEmyOM12pP4F0hSzZbcVMZyFWITuSTNFUs6W3MzllcXUA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDZCMXZsMFQvSlVTWHhTVGpKeTVTUnNjZ2paT0dUSUxYWkp0N3lOandiNi9n?=
 =?utf-8?B?ZWllZ3duMGhDZERNOTNMVWV2S2JQOTlmRTFlZ2s2NmUweU9UaldrMjA2WWNL?=
 =?utf-8?B?WWN3UHdrN1VIeG1YRUp6S2k0bFFtSEpNWll5cGl0VFY2VDFZTTZtbzNHdGZn?=
 =?utf-8?B?eU9HYldKKzVSeGZVVjI5Zzh2QWlzQTdiSThNbEhZelFPanlNbmY1UnpSYUVH?=
 =?utf-8?B?U2Q0WnpCRng2Zi9JZzNRd2pIeWlsYkluNjVsRjdCd0lrRFMyTnFiclI3a3Qy?=
 =?utf-8?B?eVNSV3hjRnRYeFAzWXpzb3hGdmRsc1R1eGozczc1UWVRTmpVVTFOMFVrTmhl?=
 =?utf-8?B?d2lLaWZiMFFpV1FKOG41blFyNUZ0RmZ6L1g1RWFnVW5TTG9obzgvcG9NRVJE?=
 =?utf-8?B?cjNQVjVwNGtOejRUS2ZrSWRDeFRRYm1OdGJZRnduOWRqemJBdEY4RmlqVVNE?=
 =?utf-8?B?Wk91THJ6V1RCR1FPUEVuMmJVeVVCaGR2bTJXTnBJZDdOb1pyMDNtVHJTMWFO?=
 =?utf-8?B?M3l1QlRvTERaaGorVGkyUnRkR0VOOURQbkFKRHl2RG1kaHpLNkplTG1jWlJx?=
 =?utf-8?B?VzdWMzIxNFBWVkh4RDJyNG5sbjNLSlV3QmRGL2NLbklJbDVqazdZMnRveFBr?=
 =?utf-8?B?aWFXN0FseVM5aHFPZUIvVENFUGZhVzVaVGZ4eitHT2pBRndWUFhIMTM2SzhK?=
 =?utf-8?B?ZU5aQitENERxQ1F0SnhZdTEyWDlKblZCYVBiSUZFZlMvQTBGb3B4b1lHaHFL?=
 =?utf-8?B?R1dCcUNWWlJQcGFFUUE0aU4xRE9zNVlQSEdtYXprckQwUlFzRDV5RUpCWlZH?=
 =?utf-8?B?K0xsbFZaU1NzUXNWM3VmVi9KSU5sN3JUWFNWcGVxbk81c25TV3h5enpTcUJz?=
 =?utf-8?B?d3M5elAvSnpPRmViREpNdk1ZMTJ0aVJDKzJ2S0RyNlpyMGg5NTZ2Y2NES3gw?=
 =?utf-8?B?SlRhNUVoRlYxZ1BqVkVKemgwSmUyZUtoRklwcy91YlVYYnltQ3hMclZyS0Y3?=
 =?utf-8?B?STlwRnJXcnMxSWl3cUc2ZWZFSXZFdlZQa1psc0VYVCtsenhwcXJlWjAwY0VL?=
 =?utf-8?B?UjhSWCszRmZSbmlvSWN3UGZQUEc0V01PUnhVaFlvd00vdll4VkM2bFJZWm1n?=
 =?utf-8?B?eG9QMGpLRzhSR0xaTDJHZXltY0VXaVdxSFp5YjZWcitWWXhpeHY5VEEyVnJu?=
 =?utf-8?B?a3lnZUF1MTFrVWhCZEZWZDlSLzFPK1ppaEVMMkRpMGIwZElJVkdGMVZtVjZ0?=
 =?utf-8?B?N0xQNnJLNEx5dHN4cUo5ZEtRNXUwL2ZBOW9oeUdUT2xpVlVWSUhNSXIzL2NP?=
 =?utf-8?B?OFcwcGpKcGNBVk4rengrK3VuZlZRVUVxdEl0UzAzZUF4V0xQNTZDdTNyRXpT?=
 =?utf-8?B?RUYxdlU2MWdSb2trb3JabWhmU1FGeDJsaHNKMmNWMGlCOE5xNE5UYThxK1BE?=
 =?utf-8?B?aG9CWERkZFVqOFM4cmc0ZzlvUlhvSDlrRWZvNDY3UU93SkVRWTIyck9ZSDM5?=
 =?utf-8?B?V25CQSs4KzFRa0syTlhtRytKK3BGenZoV29RVnNxR3NjaHUxOVV0TkVnaXVs?=
 =?utf-8?B?NElKcGdrbVZhUjF1Rlg5blRKV280d0k4WmNRZGROUFVrRldkb0ZJeXJRMTc3?=
 =?utf-8?B?OEthcDNkaUVqREcyVGJmcWYyNGRZNTRzK204U2FtQ2ZhL0ZKZmJJcm90WitK?=
 =?utf-8?B?bFdERGlrRFRwQWFZSkFzaEFJak81RG9uOHJ5dFgxS2FuNHRuUEpFVUhRPT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3ab157-be84-43a2-b4b7-08da6494e11a
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 05:59:42.9968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1073
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
> > The syscall information below show that map name
> > "process_pinned_map"
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
> > @@ -4328,6 +4328,7 @@ int bpf_map__reuse_fd(struct bpf_map *map,
> > int
> > fd)
> >  {
> >         struct bpf_map_info info = {};
> >         __u32 len = sizeof(info);
> > +       __u32 name_len;
> >         int new_fd, err;
> >         char *new_name;
> >  
> > @@ -4337,7 +4338,12 @@ int bpf_map__reuse_fd(struct bpf_map *map,
> > int
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

If  A map name is defined as being longer than name_len (name_len is 
"BPF_OBJ_NAME_LEN - 1" in this context), a program will fail to get a
reused bpf_map by bpf_object__find_map_by_name().
   
   fromhttps://github.com/libbpf/libbpf/blob/master/src/libbpf.c#L9295,
   pos->name in bpf_object__find_map_by_name() is from  new_name
in      
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



