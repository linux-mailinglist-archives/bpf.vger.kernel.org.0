Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB25885F3
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 05:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiHCDEV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 23:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiHCDEQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 23:04:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EC728E13
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 20:04:15 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272NiAqN013177
        for <bpf@vger.kernel.org>; Tue, 2 Aug 2022 20:04:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Uu8E0QEe72uSQ2tesdHtVMXkLcC0FclKycKrJvaNi2k=;
 b=fFSy6CsMK4O2q6ni6xrMsJEg2PGZcSN5IRPWBgqnsGBikgiANw+hh0pTKu+6X3VL6AaW
 3naWnwN14QzSnnA8Oz/3s7ccXj5FfkYbewIhrcs5t4xGax5yAUpAzMOxe/OEZlKSLCFf
 ZWkJgvsY7qREpHPsYtzRX4CQoZUwV2eb+c4= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hq2bpx1rr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 20:04:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXQEgthCiCbsJBzM1eYwTC5VhpZi9WifufyODwywsHbd/6gjSBkQLjMXLQPMMHFthDOUXtkuRa706+qCGhvuKOp17afkkR5yE7dNu6cPWpy9C+H835bZ670nWoOy94EZwFd0uJPn7bu3yXYlKdcNKdqUcwkU3KcYPlJqEAYHpfSWUiIZV56fvbNQrr6Q5x3nKAhHv7M6C/vlVikHNa55VlZTZ1eKdzOdS15m9atavtElhRjEAZCJ/mOIEdWS0oUVUMmhHA3R8URaJiUdrFVTcLaLIkZHJmZ2PJjEobxyjVbVr/Z4kpgFx9pWZWMelIfehGC+0CfORcIIMaqMzbNhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu8E0QEe72uSQ2tesdHtVMXkLcC0FclKycKrJvaNi2k=;
 b=J0T0EkS4/Q97j9wa1YFX/aD6BKk4GYYxEf5ZsI769QAxuVpqiWk0Pp8A6M5tD7J6adj59lN7z4F5+A5+a6B2nMJSBGc4uj63ka/kaMLiEu+Bc7HPFvpfSjnVEq2eMMEXNFUlp9OqvWorqkRKI73dW/yqtckIKYTLQ6wVghB37+aLevOhz1/BhoeBVQ0EZxZE6mvjJN6UcWijIwp/x3pmZV92gPK23HbePYqoY+yfQqmmn70Rh4jiy/5a+Q+VzrIPufKjDqjV9DAB3lOEUtt+N3/TH9uB9xvtDaKbL1IlOESL36Dio8EuF/jaZ0banMazOsAjr8oTU71XRaOFPtjHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MWHPR15MB1181.namprd15.prod.outlook.com (2603:10b6:320:30::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 03:04:11 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%7]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 03:04:10 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Martin Lau <kafai@fb.com>
CC:     =?utf-8?B?RGFuaWVsIE3DvGxsZXI=?= <deso@posteo.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Song Liu <song@kernel.org>
Subject: Re: [BUG] Possible deadlock in bpf_local_storage_update
Thread-Topic: [BUG] Possible deadlock in bpf_local_storage_update
Thread-Index: AQHYpr6+MnaCb0K0n0qd8N5fICNILK2cTeGAgAAwCAA=
Date:   Wed, 3 Aug 2022 03:04:10 +0000
Message-ID: <C9ED0EFD-2459-4C4A-9012-6AD98D586808@fb.com>
References: <20220802222506.h7uekapwj5tioj5a@muellerd-fedora-MJ0AC3F3>
 <20220803001215.wley3iom4f7rcojc@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220803001215.wley3iom4f7rcojc@kafai-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 714e866b-f654-45df-a985-08da74fcd6b8
x-ms-traffictypediagnostic: MWHPR15MB1181:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wcekrHrJzscRB0zH7KjT4NB4AjP/3amYp5+WEVqYWzkg9E0WSepNL/VX145jTrQ74GsH9qJp+ssA8MCl0gUYKVlfvIV85Y4f1qNxakW1Y3+rigUr0lEKbmivYwoLfpzSa7n3/fxJB5coWnLO//13wFoJeF6qQTJFQLzw6FjFCPczzpx4q1x4KQzzxQXWpMXbz4or/MJ0uY6UwfmM2hinWYajyXTyIB29q/f39Z06c/0tGThKT4POpFqIt4lOWiFsdufrhYQlJxgUoc49vNlykOykHM0TC5Yjq1c/m65cXu6mZ6x9u7RN3Zgv/1FKmq8jqJbRFEb03Sa32O4ikUx1km4Z0cOIUE2awBotXt+ULY9bshx3oKz5cjxrhMjUmA3qB77mV2P5kgduiI7ylIYuqVC/zJahnfKCV9bjVtJq0e0lDCXDJRLSY0MRGevKSPcc+r8ZxA9PhvuF/pFrVCrmyyYxAjuz28mtOvux3jAvLvBUYK1DURH7rX7pEQSMcoXwPFDBm8FnXTuopwGe7goZK7OfGykQdvh/KUnUoATxO2erQePzzGstnrVIFTiu4f/VS4QTR97FvN+aiTMqN0N5TWsuN8rfoWH1RwXFgTHSRtfXUyvIHhk0b12nIHLQuYBVD1PHF+gse1TqaCANhz379cI5AkGoRwHVNAa83dIWXqq08D/ucfJBCMcDFAgqOI1NaoTIPwZ7PhdpNsiowxwxBkSRp+ktIwwIWpYeRfz/bESm3gQF9HoXKw/40HPoTHze8F8eCek77GSKQC0eRHYtM8bHLJ1lVCPbefohHzcM9622x14PhLPRrA7fcXaH+y4Jz7wnM7FyRELoss4CKAMWuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(64756008)(66476007)(2906002)(71200400001)(41300700001)(38070700005)(6506007)(91956017)(66556008)(53546011)(33656002)(76116006)(4326008)(38100700002)(6512007)(8676002)(122000001)(66446008)(66946007)(8936002)(86362001)(5660300002)(83380400001)(36756003)(478600001)(66574015)(186003)(6862004)(316002)(6486002)(54906003)(2616005)(6636002)(37006003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHVvN3gwVEpJWjk5R1BNbExyTmxHK3BQd0UxaW1yOFZKRFA5Q3NkTk4xaHlz?=
 =?utf-8?B?QmFaN285VzlyZExGL1hyQXNhNGZ4WVkxWlRMWUV5T1gvckVGOUUrMTFDUU5n?=
 =?utf-8?B?c3VORkJhaWxxTUFyaGJueE45Z05lWUtjVmNBazRpVTVmOFladHMxeEpNeGd6?=
 =?utf-8?B?ODlaTkVTOCtMNUsvSHZTdlFJUlJmbDk5dktPQmJxc2FDS3JIblpkcnZ0ajh3?=
 =?utf-8?B?YTNqVnJmNlNkZitEQnd6Q1hzZEJvd2pzWVJlK2UrWENTUGpUMTlYQVltZ2Rk?=
 =?utf-8?B?OWJmNmthOGNTQ2t3TjcrQTJJQUV5dEZOcWowckNRTjFHQ1FTbXgrZWVsM05E?=
 =?utf-8?B?SDVxNWZuZE5OU0FMbjBJOG5ucjk3QzVqdk5HNmVrM2t5YUFwZjdoeTkyemxM?=
 =?utf-8?B?NFhyb2FqbzZNRWd2UWxhOUpGZ09yTUw5QUZiRmlTSG1Ndmg5WVI5SHZFU3Bq?=
 =?utf-8?B?eDc0OVBQbm5MVUsxaDdLVzBwR3BzWE4rY3VTZDluZkhEVFd6RDdPZjYwSzg4?=
 =?utf-8?B?TEFvYTFzNHNiUkhKUkhXMkZxMEs1V0ZxRlhBTCsyYmRUL2FiVnRleDczU0lL?=
 =?utf-8?B?aU95UndjQ3Z1UE5FSitydlYvWmZWZzNTRndpcCtQRXF3bTlSSmNwLzBtRVpG?=
 =?utf-8?B?T1R6d2cxbEI4QUZhZVQ4YWl5SU56Wmx6VFNnQU1oaVErZlZtWm1xSE5KN3dv?=
 =?utf-8?B?VEZQV1BhdVpXNmdEMUVPNUg0S3pUOU9LNnMrNHFxUjRlOGpHOUhmeXdCeVZU?=
 =?utf-8?B?M2FWRHVMN0U1em5zc2k5RzJzR2pZQjRzZ2ltd1pZaDE1RzRxTktjSE9LRTRr?=
 =?utf-8?B?ODBYZ25QeW1iYUdSWXg5REZwZ2xWN09taTRMNWZpSWd2WDFDL25jK203TTFa?=
 =?utf-8?B?Mm1Dc3p1TFgvU0F6UjRZcTVGNVlGSU4wV3A2OEZTSHAvb1hzSXNJSjFiK1pU?=
 =?utf-8?B?OFVqTUJyY0VxM0NudjVxdG1HRktGSENFV010MzN4Mk1WMGRReDBLeVlndVFR?=
 =?utf-8?B?YzRxbXRYWnozSm5kdHo2K2M4dXloV1cyc1hBekVzVm9ranR1NEJrRnZHYjVo?=
 =?utf-8?B?WDlWQWpzR3JLZFE2VTNSMXFTVGZpd3BoWVNnNnoyRzA4K0JxQ3JIME1yQ3Av?=
 =?utf-8?B?L1pSY1lhaFA1Z0E4VXlhZVltL2w3Uk8ycUY1Y2NKOCtjRGNzYlhsNFNWTnE0?=
 =?utf-8?B?b0pXakRUb3liNjJ1MVdHZUVBamp0RzlrQWk2dzVYcnViUVVzR002RnBsSllI?=
 =?utf-8?B?Zitvd3dDY1VKeFlGK0dGNjJUTmpkeW45em11ME4wRzdzV3FjWm8wQVZYY0xq?=
 =?utf-8?B?bVB0dGdONmtMSEdtTmJRR2pWYUZYUEhvaE9ZVjNIUldubloySlV3UlgxWVp0?=
 =?utf-8?B?U0NRR1dheWxxMXd6WGIrdXhscWo0a3I0R1BEUkVDR3VpN2ZGdXdVMWtaQ3Rz?=
 =?utf-8?B?RTd6Qll0NWQwT0pOL01nMWo1UU5PU0ZDa29iWE1kM0ZpSnJZVk9ScTRRTW9P?=
 =?utf-8?B?ODh6TE1EdWN1bVZ0cktmc0RyTlcyWWkyR3dTUXNrUnovbnJNTEhieUdKdVNq?=
 =?utf-8?B?ekZTeUgvTVRvckRlanlhKzM4L3c1YTFQeFM2Y3MvUGFVVVhXMzgzdzJVWnNK?=
 =?utf-8?B?OHoraDB3Ylcvb1oxZ3JkbHdlenFRYXRVbVdaSzZER0VJZmlqandQK0d6VGM3?=
 =?utf-8?B?ZXFIcS9SU0RlUFRYc0M4cEEzT1pzK3M1MWlBMHg0MDJ0YjFwQ2loK0lKVGMy?=
 =?utf-8?B?eGtESFZZaEkvOHg5Y2wzTmRqZTNLUlIzR1kwWWw5SlVLY1hHWlJzZzk5aldw?=
 =?utf-8?B?UmVRL2NkeXJVMyt3YzZWdVZDcmQ2YVpOek5WZnl4ZS8yU212Y1BwWisyYjlM?=
 =?utf-8?B?RnZUM0wzMXIrbmNMTDRHWnRXLy9lZDB2d0lmU2UvNEVORU14RFhVN0t4aERZ?=
 =?utf-8?B?blh5NHRWQ2JtZDY0UGM1dWRHWDVVdTRRVWRERXh1SUk4OEhnOWFSZE9HZ2FN?=
 =?utf-8?B?Mlk4bUJVM2xmUWNBY2h6ZkFIWjVLNmdWaFBxL3JZZmlSaTFVRVovR0tnWXVK?=
 =?utf-8?B?SXdRNWZnbWhTTTNFQ2tzT1EyMEZDTFQ0cEFDTjlpYjZKbGtoUkI0SWNnMkFr?=
 =?utf-8?B?YkppanhiUlJLeVI1d3pzcDVDQ2FneXhuUG5HWmt2ZGt4TG9BcmFrRU5ld3Zk?=
 =?utf-8?Q?4i4E7/hoHWnK5BkhW1gqpGU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C4AFE1E31725B499ED97DD067B15CE7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714e866b-f654-45df-a985-08da74fcd6b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 03:04:10.8884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAxEiu70sx9juGtdUQx1xYrOxgQR3Wk041P7ksW3KI8MxXnm6huV1fFuRHgyPDBHnnwd7NKpgsSqhc/2psC0IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1181
X-Proofpoint-ORIG-GUID: iB5FgvN8TRtYATZa0PCU576CjB6BJfIj
X-Proofpoint-GUID: iB5FgvN8TRtYATZa0PCU576CjB6BJfIj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_01,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gT24gQXVnIDIsIDIwMjIsIGF0IDU6MTIgUE0sIE1hcnRpbiBMYXUgPGthZmFpQGZiLmNv
bT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIEF1ZyAwMiwgMjAyMiBhdCAxMDoyNTowNlBNICswMDAw
LCBEYW5pZWwgTcO8bGxlciB3cm90ZToNCj4+IEhpLA0KPj4gDQo+PiBJJ3ZlIHNlZW4gdGhlIGZv
bGxvd2luZyBkZWFkbG9jayB3YXJuaW5nIHdoZW4gcnVubmluZyB0aGUgdGVzdF9wcm9ncyBzZWxm
dGVzdDoNCj4+IA0KPj4gWyAgMTI3LjQwNDExOF0gPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0NCj4+IFsgIDEyNy40MDkzMDZdIFdBUk5JTkc6IHBvc3NpYmxlIHJl
Y3Vyc2l2ZSBsb2NraW5nIGRldGVjdGVkDQo+PiBbICAxMjcuNDE0NTM0XSA1LjE5LjAtcmM4LTAy
MDU1LWc0M2ZlNmMwNTFjODUgIzI1NyBUYWludGVkOiBHICAgICAgICAgICBPRQ0KPj4gWyAgMTI3
LjQyMTE3Ml0gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+
IFsgIDEyNy40MjYyNTZdIHRlc3RfcHJvZ3MvNDkyIGlzIHRyeWluZyB0byBhY3F1aXJlIGxvY2s6
DQo+PiBbICAxMjcuNDMxMzU2XSBmZmZmOGZmZTBkNmM0YmI4ICgmc3RvcmFnZS0+bG9jayl7Ky4t
Ln0tezI6Mn0sIGF0OiBfX2JwZl9zZWxlbV91bmxpbmtfc3RvcmFnZSsweDNhLzB4MTUwDQo+PiBb
ICAxMjcuNDQwMzA1XQ0KPj4gWyAgMTI3LjQ0MDMwNV0gYnV0IHRhc2sgaXMgYWxyZWFkeSBob2xk
aW5nIGxvY2s6DQo+PiBbICAxMjcuNDQ1ODcyXSBmZmZmOGZmZTBkNmM0YWI4ICgmc3RvcmFnZS0+
bG9jayl7Ky4tLn0tezI6Mn0sIGF0OiBicGZfbG9jYWxfc3RvcmFnZV91cGRhdGUrMHgzMWUvMHg0
OTANCj4+IFsgIDEyNy40NTQ2ODFdDQo+PiBbICAxMjcuNDU0NjgxXSBvdGhlciBpbmZvIHRoYXQg
bWlnaHQgaGVscCB1cyBkZWJ1ZyB0aGlzOg0KPj4gWyAgMTI3LjQ2MTE3MV0gIFBvc3NpYmxlIHVu
c2FmZSBsb2NraW5nIHNjZW5hcmlvOg0KPj4gWyAgMTI3LjQ2MTE3MV0NCj4+IFsgIDEyNy40Njcz
NzddICAgICAgICBDUFUwDQo+PiBbICAxMjcuNDY5OTcxXSAgICAgICAgLS0tLQ0KPj4gWyAgMTI3
LjQ3MjQ5N10gICBsb2NrKCZzdG9yYWdlLT5sb2NrKTsNCj4+IFsgIDEyNy40NzU5NjNdICAgbG9j
aygmc3RvcmFnZS0+bG9jayk7DQo+PiBbICAxMjcuNDc5MzkxXQ0KPj4gWyAgMTI3LjQ3OTM5MV0g
ICoqKiBERUFETE9DSyAqKioNCj4+IFsgIDEyNy40NzkzOTFdDQo+PiBbICAxMjcuNDg1NDM0XSAg
TWF5IGJlIGR1ZSB0byBtaXNzaW5nIGxvY2sgbmVzdGluZyBub3RhdGlvbg0KPj4gWyAgMTI3LjQ4
NTQzNF0NCj4+IFsgIDEyNy40OTIxMThdIDMgbG9ja3MgaGVsZCBieSB0ZXN0X3Byb2dzLzQ5MjoN
Cj4+IFsgIDEyNy40OTY0ODRdICAjMDogZmZmZmZmZmZiYWY5NGI2MCAocmN1X3JlYWRfbG9ja190
cmFjZSl7Li4uLn0tezA6MH0sIGF0OiBfX2JwZl9wcm9nX2VudGVyX3NsZWVwYWJsZSsweDAvMHhl
MA0KPj4gWyAgMTI3LjUwNTg4OF0gICMxOiBmZmZmOGZmZTBkNmM0YWI4ICgmc3RvcmFnZS0+bG9j
ayl7Ky4tLn0tezI6Mn0sIGF0OiBicGZfbG9jYWxfc3RvcmFnZV91cGRhdGUrMHgzMWUvMHg0OTAN
Cj4+IFsgIDEyNy41MTQ5ODFdICAjMjogZmZmZmZmZmZiYWY5NTdlMCAocmN1X3JlYWRfbG9jayl7
Li4uLn0tezE6Mn0sIGF0OiBfX2JwZl9wcm9nX2VudGVyKzB4MC8weDEwMA0KPj4gWyAgMTI3LjUy
MzMxMF0NCj4+IFsgIDEyNy41MjMzMTBdIHN0YWNrIGJhY2t0cmFjZToNCj4+IFsgIDEyNy41Mjc1
NzRdIENQVTogNyBQSUQ6IDQ5MiBDb21tOiB0ZXN0X3Byb2dzIFRhaW50ZWQ6IEcgICAgICAgICAg
IE9FICAgICA1LjE5LjAtcmM4LTAyMDU1LWc0M2ZlNmMwNTFjODUgIzI1Nw0KPj4gWyAgMTI3LjUz
NjY1OF0gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5
NiksIEJJT1MgcmVsLTEuMTUuMC0wLWcyZGQ0YjliM2Y4NDAtcHJlYnVpbHQucWVtdS5vcmcgMDQv
MDEvMjAxNA0KPj4gWyAgMTI3LjU0NzQ2Ml0gQ2FsbCBUcmFjZToNCj4+IFsgIDEyNy41NDk5Nzdd
ICA8VEFTSz4NCj4+IFsgIDEyNy41NTIxNzVdICBkdW1wX3N0YWNrX2x2bCsweDQ0LzB4NWINCj4+
IFsgIDEyNy41NTU3NThdICBfX2xvY2tfYWNxdWlyZS5jb2xkLjc0KzB4MTUxLzB4MmFhDQo+PiBb
ICAxMjcuNTYwMjE3XSAgbG9ja19hY3F1aXJlKzB4YzkvMHgyZjANCj4+IFsgIDEyNy41NjM2ODZd
ICA/IF9fYnBmX3NlbGVtX3VubGlua19zdG9yYWdlKzB4M2EvMHgxNTANCj4+IFsgIDEyNy41Njg1
MjRdICA/IGZpbmRfaGVsZF9sb2NrKzB4MmQvMHhhMA0KPj4gWyAgMTI3LjU3MjM3OF0gIF9yYXdf
c3Bpbl9sb2NrX2lycXNhdmUrMHgzOC8weDYwDQo+PiBbICAxMjcuNTc2NTMyXSAgPyBfX2JwZl9z
ZWxlbV91bmxpbmtfc3RvcmFnZSsweDNhLzB4MTUwDQo+PiBbICAxMjcuNTgxMzgwXSAgX19icGZf
c2VsZW1fdW5saW5rX3N0b3JhZ2UrMHgzYS8weDE1MA0KPj4gWyAgMTI3LjU4NjA0NF0gIGJwZl90
YXNrX3N0b3JhZ2VfZGVsZXRlKzB4NTMvMHhiMA0KPj4gWyAgMTI3LjU5MDM4NV0gIGJwZl9wcm9n
XzczMGUzMzUyOGRiZDI5Mzdfb25fbG9va3VwKzB4MjYvMHgzZA0KPj4gWyAgMTI3LjU5NTY3M10g
IGJwZl90cmFtcG9saW5lXzY0NDI1MDU4NjVfMCsweDQ3LzB4MTAwMA0KPj4gWyAgMTI3LjYwMDUz
M10gID8gYnBmX2xvY2FsX3N0b3JhZ2VfdXBkYXRlKzB4MjUwLzB4NDkwDQo+PiBbICAxMjcuNjA1
MjUzXSAgYnBmX2xvY2FsX3N0b3JhZ2VfbG9va3VwKzB4NS8weDEzMA0KPj4gWyAgMTI3LjYwOTY1
MF0gIGJwZl9sb2NhbF9zdG9yYWdlX3VwZGF0ZSsweGYxLzB4NDkwDQo+PiBbICAxMjcuNjE0MTc1
XSAgYnBmX3NrX3N0b3JhZ2VfZ2V0KzB4ZDMvMHgxMzANCj4+IFsgIDEyNy42MTgxMjZdICBicGZf
cHJvZ19iNGFhZWIxMGM3MTc4MzU0X3NvY2tldF9iaW5kKzB4MThlLzB4Mjk3DQo+PiBbICAxMjcu
NjIzODE1XSAgYnBmX3RyYW1wb2xpbmVfNjQ0MjQ3NDQ1Nl8xKzB4NWMvMHgxMDAwDQo+PiBbICAx
MjcuNjI4NTkxXSAgYnBmX2xzbV9zb2NrZXRfYmluZCsweDUvMHgxMA0KPj4gWyAgMTI3LjYzMjQ3
Nl0gIHNlY3VyaXR5X3NvY2tldF9iaW5kKzB4MzAvMHg1MA0KPj4gWyAgMTI3LjYzNjc1NV0gIF9f
c3lzX2JpbmQrMHhiYS8weGYwDQo+PiBbICAxMjcuNjQwMTEzXSAgPyBrdGltZV9nZXRfY29hcnNl
X3JlYWxfdHM2NCsweGI5LzB4YzANCj4+IFsgIDEyNy42NDQ5MTBdICA/IGxvY2tkZXBfaGFyZGly
cXNfb24rMHg3OS8weDEwMA0KPj4gWyAgMTI3LjY0OTQzOF0gID8ga3RpbWVfZ2V0X2NvYXJzZV9y
ZWFsX3RzNjQrMHhiOS8weGMwDQo+PiBbICAxMjcuNjU0MjE1XSAgPyBzeXNjYWxsX3RyYWNlX2Vu
dGVyLmlzcmEuMTYrMHgxNTcvMHgyMDANCj4+IFsgIDEyNy42NTkyNTVdICBfX3g2NF9zeXNfYmlu
ZCsweDE2LzB4MjANCj4+IFsgIDEyNy42NjI4OTRdICBkb19zeXNjYWxsXzY0KzB4M2EvMHg5MA0K
Pj4gWyAgMTI3LjY2NjQ1Nl0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDYzLzB4
Y2QNCj4+IFsgIDEyNy42NzE1MDBdIFJJUDogMDAzMzoweDdmYmJhNGIzNmNlYg0KPj4gWyAgMTI3
LjY3NDk4Ml0gQ29kZTogYzMgNDggOGIgMTUgNzcgMzEgMGMgMDAgZjcgZDggNjQgODkgMDIgYjgg
ZmYgZmYgZmYgZmYgZWIgYzIgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgOTAgZjMgMGYg
MWUgZmEgYjggMzEgMDAgMDAgMDAgMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSA4DQo+
PiBbICAxMjcuNjkyNDU3XSBSU1A6IDAwMmI6MDAwMDdmZmY0ZTljOWRiOCBFRkxBR1M6IDAwMDAw
MjA2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDMxDQo+PiBbICAxMjcuNjk5NjY2XSBSQVg6IGZm
ZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwN2ZiYmE1MDU3MDAwIFJDWDogMDAwMDdmYmJhNGIzNmNl
Yg0KPj4gWyAgMTI3LjcwNjQ0OF0gUkRYOiAwMDAwMDAwMDAwMDAwMDFjIFJTSTogMDAwMDdmZmY0
ZTljOWU0MCBSREk6IDAwMDAwMDAwMDAwMDAwMzUNCj4+IFsgIDEyNy43MTMyNDddIFJCUDogMDAw
MDdmZmY0ZTljOWUwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMTAgUjA5OiAwMDAwMDAwMDAwMDAwMDAw
DQo+PiBbICAxMjcuNzE5OTM4XSBSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAw
MDAwMjA2IFIxMjogMDAwMDAwMDAwMDQwZDNhMA0KPj4gWyAgMTI3LjcyNjc5MF0gUjEzOiAwMDAw
N2ZmZjRlOWNlMzMwIFIxNDogMDAwMDAwMDAwMDAwMDAwMCBSMTU6IDAwMDAwMDAwMDAwMDAwMDAN
Cj4+IFsgIDEyNy43MzM4MjBdICA8L1RBU0s+DQo+PiANCj4+IEkgYW0gbm90IGVudGlyZWx5IHN1
cmUgSSBhbSByZWFkaW5nIHRoZSBjYWxsIHRyYWNlIGNvcnJlY3RseSAob3Igd2hldGhlciBpdA0K
Pj4gcmVhbGx5IGlzIGFsbCB0aGF0IGFjY3VyYXRlIGZvciB0aGF0IG1hdHRlciksIGJ1dCBvbmUg
d2F5IEkgY291bGQgc2VlIGENCj4+IHJlY3Vyc2l2ZSBhY3F1aXNpdGlvbiBpcyBpZiB3ZSBmaXJz
dCBhY3F1aXJlIHRoZSBsb2NhbF9zdG9yYWdlIGxvY2sgaW4NCj4+IGJwZl9sb2NhbF9zdG9yYWdl
X3VwZGF0ZSBbMF0sIHRoZW4gd2UgY2FsbCBpbnRvIGJwZl9sb2NhbF9zdG9yYWdlX2xvb2t1cCBp
biBsaW5lDQo+PiA0MzkgKHdpdGggdGhlIGxvY2sgc3RpbGwgaGVsZCksIGFuZCB0aGVuIGF0dGVt
cHQgdG8gYWNxdWlyZSBpdCBhZ2FpbiBpbiBsaW5lDQo+PiAyNjguDQo+IGJwZl9sb2NhbF9zdG9y
YWdlX2xvb2t1cCguLi4sIGNhY2hlaXRfbG9ja2l0ID0gZmFsc2UpIGlzIGNhbGxlZCwNCj4gc28g
aXQgd29uJ3QgYWNxdWlyZSB0aGUgbG9jayBhZ2FpbiBhdCBsaW5lIDI2OC4gIEFsc28sIGZyb20g
dGhlIHN0YWNrLA0KPiBpdCBpcyB0d28gZGlmZmVyZW50IGxvY2tzLiAgT25lIGlzIHRoZSBzayBz
dG9yYWdlIGxvY2sgYW5kIGFub3RoZXIgaXMNCj4gdGhlIHRhc2sgc3RvcmFnZSBsb2NrLCBzbyBu
byBkZWFkIGxvY2suDQo+IA0KPiANCj4gSXQgaXMgcHJvYmFibHkgdHJpZ2dlcmVkIHdoZW4gdGhl
ICJvbl9sb29rdXAiIHRlc3QgKHVzaW5nIHRoZSB0YXNrIHN0b3JhZ2UpDQo+IGluIHRhc2tfbHNf
cmVjdXJzaW9uLmMgaXMgcnVubmluZyBpbiBwYXJhbGxlbCB3aXRoIG90aGVyIHNrL2lub2RlIHN0
b3JhZ2UgdGVzdHMuDQo+IENjIFNvbmcgaWYgaGUgaGFzIGluc2lnaHQgb24gaG93IHRvIGFubm90
YXRlIGxvY2tkZXAgaW4gdGhpcyBjYXNlLg0KDQpJIHRoaW5rIHdlIGNhbiB1c2UgbG9ja19jbGFz
c19rZXkgdG8gYW5ub3RhdGUgdGhlc2UgbG9ja3MuICBUaGVyZSBpcyBzb21lIGV4YW1wbGUNCmlu
IGhhc2h0YWIuYyAobG9ja2RlcF9zZXRfY2xhc3MsIGxvY2tkZXBfcmVnaXN0ZXJfa2V5LCBldGMu
KS4gDQoNClRoYW5rcywNClNvbmc=
