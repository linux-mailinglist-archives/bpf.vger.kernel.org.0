Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84855C001A
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 16:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiIUOlg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 10:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIUOle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 10:41:34 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021022.outbound.protection.outlook.com [52.101.57.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CBF43302
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 07:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpW++9Lr8ODiueNDs8pyv57eupPnojqpCgi8RzUCtb6veZXyAsczLrojXIT3EBmNkZizpRwNE5HWFbF9zGrQSarUtJ64CPZnWIJZBnzyG/j2qiyf5HKVUMeFdfijbGt5nsoALGtkuMZY9ewGR5vXjv1DrhHVcCwOIfz6gCp9tS37n545vPY5/z6jFadVLlTyNHfXAFYc7whVxifg8nTiim3Y6OgyySkJ7R/wMuBm9rNs4W1Sq0ELcd7aAkB4SVEtWiq9HHlPZLRu8WapUDTlGtPaZu9wVSARqKwITgGApxAOMguBbdtmo4KvALs+E3ZphY6RPodawtsihNCfbaVgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hDLyiFH3u2ShCfGzZVbuZa8gFcQiDevA3Df1dZ5f+A=;
 b=YbCMthczEio6api9Q8gKtwTT6mJMmQUzn5mq0MRBRwQ60Esc5LyFwzzvApgPxzYTpmcggRmOnNznU2lLn21lCff7zUqAuuQsGhkd3gSak3t88Usx1THTrKielQPiX/Pb4KXvM+AHLFVBrUxd+4zjLN3H0FF8aIZ8nLPuB980PeR84mwtHD3jO7VIo9JJOBe28QRk2ifxqmMoLWa7g1TT8GGNtH5Nm5EVIgIT6YLKoNfgOsKFF+IO5BlN3eMZvdzxe0igVdvuJaHXIbIp6G5+9ccfQkExFpci8dXNvsGv26pN+0FrBzZFgeP7JqmtPH35vkeWR69kHlLpot6I9hukmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hDLyiFH3u2ShCfGzZVbuZa8gFcQiDevA3Df1dZ5f+A=;
 b=jQRcSaY5Lb8/IA1Hqgp7laVz08SG/X/1fHl5yEEFbiVuxFa9DfgRwX0CXu5LxQYUkUwakDa1DriSDfKH8wtYtsR6VPsgPDAMCtuHiRZLKwJ5o/1BVA4dtsIEx03Ga4viw17Iz+09mom3R1DB4yw9Qhq57v3wkM4lxkWJIx1jJqA=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 IA1PR21MB3448.namprd21.prod.outlook.com (2603:10b6:208:3e3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.7; Wed, 21 Sep 2022 14:41:28 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5872:7dd2:2a86:c111]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5872:7dd2:2a86:c111%9]) with mapi id 15.20.5676.007; Wed, 21 Sep 2022
 14:41:28 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf <bpf@vger.kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: RE: Rethink how to deal with division/modulo-on-zero (was Re: FW:
 ebpf-docs: draft of ISA doc updates in progress)
Thread-Topic: Rethink how to deal with division/modulo-on-zero (was Re: FW:
 ebpf-docs: draft of ISA doc updates in progress)
Thread-Index: AQHYzZUGCdihwV0zqkan6vEre4luya3p84mA
Date:   Wed, 21 Sep 2022 14:41:28 +0000
Message-ID: <DM4PR21MB344078B626F92E3476090082A34F9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
 <YyFzO205ZZPieCav@syu-laptop> <YyihFIOt6xGWrXdC@infradead.org>
 <DM4PR21MB344020798F08A9D967E70719A34C9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQ+bRxDkSWnx27KRm4mC3QrmPO+UyiA5VrjHNMQqeVYcNA@mail.gmail.com>
 <YyrMpAPJrP851vE1@syu-laptop>
In-Reply-To: <YyrMpAPJrP851vE1@syu-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7145740c-6245-4925-87d3-92c87dee58c4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-21T14:35:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|IA1PR21MB3448:EE_
x-ms-office365-filtering-correlation-id: 7c996192-db39-4bb7-c570-08da9bdf5df4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5WaPrp5JulNyFyNOt5H4657rklAsTmNTS5dcbzAcZCcaqAGrZw9DzwMRXa9syLTPvlhSYvKDgMR7oliSQzv4709NLxXzpmIkPcBUx8UOF9iO68/z18UhaHl+vhcxuIrEgW7xTPA0RcOXPT85biSTn5siqMb9BvTPVTCYIg3DP9xWh26L1Ru8ymtw9+ANhu+hctF+5uzUV/waGzHFJ0QMBww6/Trg1LF/w7HwhLvaxdp+ksV8YzowfBjo3XVepLibfDS+/O7s72KEbcWm7nh9/clcn48ejvGplLQHxqtt2PgQrHQJ75xtPCze3jkP8/mzvn0OTn/faj16sjlhwOgJs6LnseXyA6lhyV4k/TrMTXSASs6lq/atg+VroFLB8TrXMqnTT3xYZjz3IoXVKuRJjVJZ+c89WnXNuxV+n5+tE0PcvL0HiW3SMA5MLsciDNnspNXvTZr6lKBGIMUR0KVrgBzcpi3fsATHN8DPhfP3sdMQcp7nBDnpYXuZ30kIUKsV0LRL3GZXhlt/GEb5Q8/FGPNEqK6CduyBZQq/n3UooE0LNUmjW6YVxlRGyRnHq+e5F3PDf7emIDsds5dvgZVIJr6IbjSY+N8rB7+wSsIVyPk58VLpVMqJ0Ioy96SOr+zy34dzsqvE+Mgij3rmpfLLf5Zg+8HuCKS3SMAbVJ5yA+KPiY9POjaQ4cypZDNheZT/kC3JcmWUCZWS647KjwmMIFJN+PsIbSa61ccs4FvVW21B8xe9iKXqwlfcci01RGb8P/3WqCzeWz5MgCiIyZSBIG775zK448SeUOBEcLU+oHlYbZuctgVRlc0Jtm7JHGN4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199015)(186003)(9686003)(26005)(7696005)(71200400001)(6506007)(2906002)(8990500004)(15650500001)(83380400001)(52536014)(5660300002)(55016003)(54906003)(478600001)(10290500003)(110136005)(8936002)(8676002)(64756008)(66446008)(66476007)(66946007)(76116006)(41300700001)(316002)(66556008)(4326008)(66899012)(38070700005)(33656002)(82950400001)(86362001)(82960400001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckVheXBYRnFVWXBwRlpqWHJsZlJyT29OZHJYZWl0cjkrbnNrTGt5SVY2ZkdV?=
 =?utf-8?B?a203VWRuWTdsTDhQTnVGUjluVVA0V0Mrelp2cmd2b0lTYlhyWElJY0RkVXVJ?=
 =?utf-8?B?TjMrQkhjTTJQMk9UMGxhQko3VEpEazNNdno1UHlEN3JCTE5aaWNTRW13eUZq?=
 =?utf-8?B?MXAzVU9oR2I2aDE0OEpoOFduSExDRGp1RHlYRmgzTURibm80UUFTNWNaUWFt?=
 =?utf-8?B?VU1FZElCT0pMcjUrTEtlMWVwVkNybVVpcUlTM0F3cVB1SFdDVmJJV09BVjli?=
 =?utf-8?B?elM1TDIvK0JmeEE3dnVmeFRqTkowalNEMWdhWDR3OTBpR0lsUitmUkRubkdN?=
 =?utf-8?B?b051aXZOaW5ROVNuSkFDaWI4SHk4S3NIWDU2UGxYQXV6QWRrOUx4SEtUVUU1?=
 =?utf-8?B?OGFWYXJ5VnVNV3RFbzIxakhONTIxT0lqN3RGVnZaa2lVYSsvcmR1dEIyenhR?=
 =?utf-8?B?S3NhSlU0anNQZG83WUZRdjhpaGFqNmpuWFU1b2pRSnFqNVdua2hPTHRzNVNJ?=
 =?utf-8?B?SkxKbkVTSzN3MksxWDE4ek50LzRSZitYRXlaY2tLVGZmampaMC9FVkhmcHFn?=
 =?utf-8?B?R0JrZ0JkUkZEQXM0cnNQMVhROGtmYll5S0NhT1dBNm5hN1VrYUpYYkJrS1Nn?=
 =?utf-8?B?UFdqbFcyaS9COUV6ZEw3WkZwdWRoMWdFN0NqMG1HditKdnFZR1d6ZTJ5dmpR?=
 =?utf-8?B?Y29CaUNrS09rZmJ2eFlQc1RGZGE4ZEphcFllc0hxTWZYQVZCaGhSRkU1dGlO?=
 =?utf-8?B?S2R3YlFjOTI5WUhERTNVR2lLZ2VyUUMrTlJVU0xqZVpiQVBrakpCNjNKMExX?=
 =?utf-8?B?MmszZnRZSDhibllCQS8vbHFGNjBuakQzbFkrSjBnY3Fadlh1dzFzaUx1L0JE?=
 =?utf-8?B?QS9pcTB1WG1wc1BhbVMwcHl2eWdRT2lHbnpGTmt1VXB0ZFFteXpCaHpEN2ZL?=
 =?utf-8?B?YW5zSHdmN1YwaXNoWDFCSDNMZEIzV1JCL2hSTHhDZS9Mc21IeU1SaTVjblJC?=
 =?utf-8?B?bmFvWFRhUFo3UUhQaDF5ejBXQ28rRmxIL00xcWptazR1NU82WWxOa2paQmFW?=
 =?utf-8?B?aVFrRFMxN3VXU2FOUUpzY0NCdUpCajJnMlpXWnBKaVFXamJkZDNOWm9IazNE?=
 =?utf-8?B?SUZjQTREcjBjSUNUeDBQeHhnams2N2o4QWNldk9NbEMvaFgwc0MwTEpyZ3VV?=
 =?utf-8?B?YTJaQ0ROU09pbTY0Y0VGNExhL01SODVrbUFNbkg0NEdZWUNuTFZQbjE1WWRT?=
 =?utf-8?B?TDlseS85T0ZKZVFrZS9RZk9WL3JrKy9lc2Ruc0VFTjZVMTh1UTZyMGQ4Y0p2?=
 =?utf-8?B?NW1salkzLzlBWUFtR2p4RXZ4T1M2T0xmVmp6d3dZQmI0SGxJWHR1cXByaE5y?=
 =?utf-8?B?bStxSG40T3JxYy9NeVZySUNaUktLbkxEakxnYW5kTTZaYy9mUk1ocUpEeUtk?=
 =?utf-8?B?RkNxN0ltWUJudmtCdmwvQ2Nib2ZEZldNdllmdCtxb3VmSEk0Ry9mQmVEK09Q?=
 =?utf-8?B?eWcrWUJrWlNaRkNwMjNhcXpOWmtGUTBERHExc0ladUNES0dtU2FwYS9COE0z?=
 =?utf-8?B?TmJrMmM2QlR2TndrSHNtOEtTQmJ4dXhkR2o2QWV4SXJsOXlXT3BkZERkUlB1?=
 =?utf-8?B?Yy9lTk9ubGF5VWsrRjRlYmc4Q2I0TkRIYi9XZUpsaEl6WThzcUdNaGRRa3RB?=
 =?utf-8?B?RG1RZGFGUnc4WGVzbE1sU2o5TW5nZEowdGNZL1dlWnAySkk1eVpud3VTU1Rh?=
 =?utf-8?B?c1NFUDRCNTFNOE0xSTVwejdzdnZRdzUwUnl5U0p0b1NNK1NBV0VDVXgzZzM2?=
 =?utf-8?B?S21obUhpUjlINWNRY3pidVQ4NjVXbjFwQXFlZ3U2VVlpQThReENUUmhPMTZZ?=
 =?utf-8?B?M1AxbTZCQ1BjSFNIWHhuT25rdjNoK3ZuYmhoM1U3cExoc05vdTA0MXFkUlNs?=
 =?utf-8?B?RVA5SlFabi85QjcyMmc1OWNnd21UTUJWdlMwdjRsWHJ2RktjakFOSXFrV0Ez?=
 =?utf-8?B?bDBHUzFSa3FIeEpaZkhaZk9tQ3krMFJaV2JRVnVYUGp0VVhMdVpEQTVJSllo?=
 =?utf-8?B?ZGpEUFVZeEVHdjBrYTROVjUveWNrSkJSVTFKR1RhSUhQOUpoazVrU05lTUE2?=
 =?utf-8?B?VnlaRmduZ1BJV3pjUXpkTC92TzJLa2pwTlAwU1lGUS9kc0xZeFo1WDE4UVN4?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c996192-db39-4bb7-c570-08da9bdf5df4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 14:41:28.2212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2HukK4/HNVYJ7czS55fSF7GI5qtvN8cC8H1zjsDMuQejOMTqN57w0Io1C3mV0UzfLWgOcCE3+5ki8EspyEN/zb6730WDcp1vgy+7W0hmVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3448
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

U2h1bmctSHNpIFl1IDxzaHVuZy1oc2kueXVAc3VzZS5jb20+IHdyaXRlczogDQo+IEp1c3QgbGlr
ZSBob3cgQlBGIHZlcmlmaWVyIHByZXZlbnRzIGEgX3Bvc3NpYmxlXyBvdXQtb2YtYm91bmQgbWVt
b3J5IGFjY2VzcywNCj4gZS5nLiBhcnJbaV0gd2hlbiBgaWAgaXMgbm90IGJvdW5kLWNoZWNrZWQu
IElkZWFsbHkgSSdkIGV4cGVjdCBhIGNvaGVyZW50DQo+IGFwcHJvYWNoIHRvd2FyZCBkaXZpc2lv
bi9tb2R1bG8tb24temVybyBhcyB3ZWxsOyB0aGUgdmVyaWZpZXIgc2hvdWxkIHByZXZlbnQNCj4g
cHJvZ3JhbSB0aGF0IF9taWdodF8gZG8gZGl2aXNpb24tb24temVybyBmcm9tIGxvYWRpbmcgaW4g
dGhlIGZpcnN0IHBsYWNlLg0KWy4uLl0NCj4gQWRtaXR0ZWRseSBldmVuIGlmIGFjaGlldmFibGUs
IHRoaXMgaXMgYSByYWRpY2FsIGFwcHJvYWNoIHRoYXQgaXMgbm90IGJhY2t3YXJkDQo+IGNvbXBh
dGlibGUuIElmIHN1Y2ggY2hlY2sgaXMgaW1wbGVtZW50ZWQsIHByb2dyYW1zIHRoYXQgdXNlZCB0
byBsb2FkIG1heQ0KPiBub3cgYmUgcmVqZWN0ZWQuDQoNCkZXSVcsIHRoZSBQUkVWQUlMIHZlcmlm
aWVyIGF0dGVtcHRlZCB0byBkbyB0aGF0LCBhbHRob3VnaCBpdCB3YXMgaW5jb21wbGV0ZSB1bnRp
bCBhIHBhdGNoIEkganVzdCBzdWJtaXR0ZWQgdG8gaXQgeWVzdGVyZGF5LiAgSG93ZXZlciwgd2hl
biBydW5uaW5nIHRoZSBwYXRjaGVkIHZlcnNpb24sIGl0IHdvdWxkIHJlamVjdCBzb21lIGNpbGl1
bSwgZmFsY28sIHN1cmljYXRhLCBldGMuIHByb2dyYW1zIHRoYXQgaXQgdXNlcyBhcyB0ZXN0IGNh
c2VzLA0Kc28gbXkgcGF0Y2ggcHJvcG9zZWQgbWFraW5nIGl0IG9wdGlvbmFsIGluIHRoYXQgdmVy
aWZpZXIgYWx0aG91Z2ggbWF5YmUgdGhlcmUncw0Kc29tZSBiZXR0ZXIgYWx0ZXJuYXRpdmUuDQoN
CkNlcnRhaW5seSBJIHRoaW5rIGEgcnVudGltZSBzaG91bGQgaW1wbGVtZW50IHRoZSAwIGNoZWNr
IGl0c2VsZiByZWdhcmRsZXNzIG9mIHdoZXRoZXIgaXQncyByZWplY3RlZCBvciBhbGxvd2VkIGJ5
IHZlcmlmaWNhdGlvbiwgYnV0IEkgd2FudGVkIHRvIHNoYXJlIGV2aWRlbmNlIHRoYXQgeW91ciAi
bWF5IG5vdyBiZSByZWplY3RlZCIgaXMgZGVtb25zdHJhYmx5IHRydWUuDQoNCkRhdmUNCg0K
