Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ECB4D6883
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 19:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350945AbiCKSio (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 13:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350947AbiCKSik (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 13:38:40 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2092.outbound.protection.outlook.com [40.107.244.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9FD377DF
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 10:37:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdSqY6IHV+Kcv+QpxkJjrVy72Dd7lHQYB1Jz5e2LtFQHPc7tHi9SI7aUci654hGrQ0RQ+q7ltk2jIcjvj0RiVWRFCk2OPFVCtc6gxMW2XBNfGNYX+d9qKFEBekILuNxrVNC0oMJr3Um2nYB3xTSUn+oBO48wI9q4KQmwZNmg8OYznaHr0tcPHT9ZhKT7u3Xcd7fUelcXlBu3Jz6v5evNY4ziu4UI/9veSxnQN4f1OykrVjHCNp2R2h04jnF2QYpwmNpq8moPtziETFX7ENLe5g0I0S4facTAR58YOCAmu+bHpHLtLcsfMPEcmXaydlE4FSaWoVdYU8dDqCNMJ1Gqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofNFsQ1CFEwWWKqzTxy8TdEAy8oJuO2vyLbJ+h82bJ8=;
 b=EAxULzsJJzwtcm2G58RKUOegP/SIVUNSagEFCDSIbjQ0CHm8wnbXYpuZp6rzbmEvXPq1DlBustViHpe+kd9jiD4UhRNIqhb6Q8kgmYjP/JezjDdLmrqH/Q3nfHD7laeXUOGFZPgtOmKaGFC4vyksrYyye1xVpmQ61uXKMeZWg1tA6UcXyLNmtNZ3fxRwNI1GeTj9/pXgum5fv9PgCQ1sTdFmt9J/6FFLSxgQRWqZRbMVPudgSYXT2tWnR3EDnOTwOfk30Go8lBbdHPcaxMWl9xwk+bSgphCZCZ41Xz6UYptXcFFs/PDqQbNy0WByI4HqIo3hK74ZTQFIGDDlWtU4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofNFsQ1CFEwWWKqzTxy8TdEAy8oJuO2vyLbJ+h82bJ8=;
 b=ZqledUvX4bKiXL/I31hkVE3wFpPh2VXfuJO/V4v53q6AjYrRwlsPtqUd8MmJOyZ95Xewpw0sF8sc/TWh/WzrVfKGHBEbbh9Od22Q6mq8Foicoz2afTTbddWPkmFvMEOXaDxCFkCLnRPbtAPKzqB4oWvFMtle5w8GURI+eRrZ1aY=
Received: from CH2PR21MB1430.namprd21.prod.outlook.com (2603:10b6:610:80::17)
 by SN6PR2101MB1069.namprd21.prod.outlook.com (2603:10b6:805:6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.10; Fri, 11 Mar
 2022 18:37:34 +0000
Received: from CH2PR21MB1430.namprd21.prod.outlook.com
 ([fe80::f990:4b74:c257:7ef5]) by CH2PR21MB1430.namprd21.prod.outlook.com
 ([fe80::f990:4b74:c257:7ef5%6]) with mapi id 15.20.5081.009; Fri, 11 Mar 2022
 18:37:34 +0000
From:   Alan Jowett <Alan.Jowett@microsoft.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH bpf-next] Support load time binding of
 bpf-helpers.
Thread-Topic: [EXTERNAL] Re: [PATCH bpf-next] Support load time binding of
 bpf-helpers.
Thread-Index: AdgyfY9KAOB35mfkQ9OERhtYbxsHugAyYmMAACHpKNA=
Date:   Fri, 11 Mar 2022 18:37:33 +0000
Message-ID: <CH2PR21MB14307F582468BB431CAABA4DFA0C9@CH2PR21MB1430.namprd21.prod.outlook.com>
References: <CH2PR21MB1430AFEB81F5F7930E8027C1FA089@CH2PR21MB1430.namprd21.prod.outlook.com>
 <CAEf4BzYsGVSTS5t=OBPpMKcGm8F0aB4PG=dxK+Pg=UeP18o0NA@mail.gmail.com>
In-Reply-To: <CAEf4BzYsGVSTS5t=OBPpMKcGm8F0aB4PG=dxK+Pg=UeP18o0NA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=30cd1ec5-54d3-4fdc-b742-c871aa065a76;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-09T16:00:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fcb3554-95e6-40c4-6707-08da038e3548
x-ms-traffictypediagnostic: SN6PR2101MB1069:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SN6PR2101MB10692701FA80B82C5D7EF3DDFA0C9@SN6PR2101MB1069.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +NH5//vMlD78qIOAcaxLsp5LSFd13cqT1d096UAFEY35UZAoFV5TywLopK20+rH5iUoaRuTNtG6z9yykp6OGCJpASio9LuY4nbjkhKdGC61uih8Ne8zebQHLCX86D7kBif8to60ftoAzBWUebgZxGRMzcKp7MmK2QiYri91zYouZIGL+tv4dJNAM732TMq6VSROJ4nvvMXNH/lxZeLRCJ145gSWr19V2zWvq+nSjG1bvLPd277479Omu92b0CWk01FLOhyXfErolndLFbWyUmRo8vHuU0SiCGql0jKvorsXjqoN7gEjidhb0RFFiG1GM3+mvY2CvoUXTyEo/gr1Epj8BX+H6k4ae9yQCcp/qW/lc+Etm4SwhDjC7PnYYwL8E2IU/eNR/hQNu11o/mX+Jxi4s48YQ/LGSsNPK7gu9UU3hH/LGv0XRU+x3/Pi+LyxgFCHmiiede2qFuGgsvuPRNwGsDwsH2c2p51A+j72DuDtqC5d/yuRCuLBoGM0PnsWqv4PI66GHPIDJH2EvPE7/8/HL7C246nHT7qBEGMqlv3wCX2DbCqBBCLwxc1NxjjPzDzJCwXUnchmnkjYlENIuslCAN6xVscX30Uw/6lyZp5zFpxpwym1R1qhc+yqk/E5RjtFLfWcWXQgVIVP2RkVr2QmW7grJtEaRxY052FEbsoPNpL2iwu22d2kRcYdTSaZJPM1KtcUrB68cD8GrDT3YCVQzoHd4snFds7R3WdDkdIemnUpyA8RWa7GQUAdsMxbP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1430.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(8676002)(64756008)(66446008)(66556008)(66476007)(66946007)(76116006)(55016003)(4326008)(8990500004)(86362001)(186003)(33656002)(83380400001)(26005)(122000001)(71200400001)(2906002)(52536014)(5660300002)(38100700002)(508600001)(10290500003)(38070700005)(53546011)(316002)(9686003)(82960400001)(82950400001)(6506007)(6916009)(7696005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEtIU3lvOXVTSXFMMHJKZnMrYldwUGlqUTBiTlpzNVovcXRhZ1NWc3pBRzFY?=
 =?utf-8?B?d2lFeEIrZ05RSk1VQlJDejU2MlVwQWNDMFVJOU9NTm5jdWJHT3E4ZGRWcFJ4?=
 =?utf-8?B?NFRHUXdaMEEvSFZNVFZCS1VxWHFxMDYxTVdwSGIyUzdBS08zK0U1Ums5WTRV?=
 =?utf-8?B?TDB0T2xLRHVBZlU2ckhwS0lqV0tEUTVqeTRBdDZ6SlpSQ1VwRXJzY2M3L29j?=
 =?utf-8?B?SzRWeWkwdzBHSDR4amFia2dNV0lTNjVISzBhR1hXTFRvNzQxeVZKQXluTjZ2?=
 =?utf-8?B?d2tydGd2OGhYUXJLZTgrWkkvd2xEWWY4UmJMMzNCVzUyYk0vcDVhUGFaQ3ZV?=
 =?utf-8?B?czFmSU1ycjd0UWxDZmlzSXVyaVBqOUJvNXRJaWJvSU5paUE4MndtYVl1T1F2?=
 =?utf-8?B?aFVKdm1ZNmxsTDFXSjlrWWJKeS9jZnpLOEwrSG45S2lITEtDUklLQTVMSi9h?=
 =?utf-8?B?Q0tCNDRwa0g4dlJLZERGb1h0S25nektIdHplaGgyUjg5TUJZd0trOWhsVk9M?=
 =?utf-8?B?NlBzd2pacGtEVXpXWkJrTGF0UGlJVGNQYVI1SmZXMVRLVHkrOFdpVlNQekdx?=
 =?utf-8?B?UGN3bzA1QmVSTnIyTVN3U2xQYmV4anU0UTE3Uk9KSHMrUEI5d3JOZ3BpZVFk?=
 =?utf-8?B?cHVBWHFIWWppcWhnSDF1UEg4TktGS3pzcUs2QkpiS1lVN1U5eVFMMlhCRDdO?=
 =?utf-8?B?QWNxdjBhdFpXWWFZTnBIeGNMcFA5K3I2anZDR2R0SzRXUkhiWndaMkwrUzJ1?=
 =?utf-8?B?NER1ZUhoWEhNaWYxRTVCYzFhdEdaZzExU2o5cFdobWJhMmVyYzh5eHFwNFdW?=
 =?utf-8?B?NGZXV2FOdERxR2RCellVK0tQS1BHa2dzL0djVTRHUDBHRWgxeWRyTUxtUXB2?=
 =?utf-8?B?MUNSMFhxbFJGZUs1VlcybXVYMTRDL2sxM3RyMXZhbThaQ3JKKzluR1lDdzlY?=
 =?utf-8?B?aWlBdzZ2Qy95K2hsRHJQUDlZLzVtRkpiWUFMa291NDBIM2tOZElIRkFxWjZV?=
 =?utf-8?B?VkF0TVJFSjJWNXJCRTlHcCtzU3dyKzdnSWE1a1ptUzNKSHd0d0QvQXRiUFFG?=
 =?utf-8?B?WEJzei8rclplSlpTZjR1S3BDMnFNVE1UVG1DVEtDcTV3ODhVelpBb0J4TjVZ?=
 =?utf-8?B?VUVjKzhXOTlYWnp3b0VqeGNsZEFid29IVTNacHg1YllBOE9zY3RDZ3B6RTR1?=
 =?utf-8?B?eUQ2UmMxNitLdm1aQVRNcmVOMTMwTzBpZXM5bXB0QnVBc3NSaGtQenZGWFNa?=
 =?utf-8?B?RjFHUTF6ZVk3aDRHTFpCb0FXdURkSnNvSlR1Mk5ua2hsYnEvazZzOERSMUh4?=
 =?utf-8?B?SDBIdWNKMW84eWhmSjhyY0dLeXJTR1k2SUIzbVRsOWZpTVhiMDJQMHptbC82?=
 =?utf-8?B?WjBjUGZiUFAzbWc0SGtneVpjVkdBdHBWOEkzdGVlNGlaMHY2cExJVnJiRDhD?=
 =?utf-8?B?WUE5SmlKU01lUlhZTHR3bXJVT21Qck0ydk8yaFRvQ2Vsc0FrWmNPdkhybUdu?=
 =?utf-8?B?VjB5OHFKVVdBTlJScE12YkR6N3c2bXR4U1VGZXhiQm9KMCtIK0l3YjMvSSsw?=
 =?utf-8?B?K0NnQ3Q0ZjlhRTRXMmpkM1g3eWFpeFByUnFkWjBIZHc2NEEzOHl2cWNUME5W?=
 =?utf-8?B?dVFOWEtLTmY3eUw2SitsKzJKbEwvZWpMNVlNQkRzRmFvV3ExMTQ4aDRIZ25s?=
 =?utf-8?B?S2orN1BwZWcwRksxMkdKODdyOUcxZTBJaGRZWFI0QTRhd3A1MVBJclRmUWhK?=
 =?utf-8?B?UWgwQkJtcVB2eHBUZksvRUFzTDQ1VWZJRURWVURkNHArTlp5YVlJdHlkcTRL?=
 =?utf-8?B?VTl6MFB5bWc1UVNYdWF2cWp3enh4bGlkQTlWdWpNcFlrV0lYc25UTFhBK3FS?=
 =?utf-8?B?SUhBOTRqOUFUaWw5S3E5b1BlZUVKZWpRL3lyUmFzdGJSc3Z2Mm1KQTVGOTRD?=
 =?utf-8?Q?yRU3oFaej+qToFaySsc6kq4mFodLCuKF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1430.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcb3554-95e6-40c4-6707-08da038e3548
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 18:37:34.0074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xG7B/fmLOyKZc1xTTF7zS7t8PW+YQSmD5DDbz2SyXQfxav/g2WWeceBx00dOfnZLF184Hc0ZJ2uYPb3RnJOXew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1069
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VGhhbmtzIGZvciB0aGUgZmVlZGJhY2ssIEkgYXBwcmVjaWF0ZSBpdC4gQW55IHN1Z2dlc3Rpb25z
IG9uIGhvdyB0byBtYWtlIHRoZSBvdXRwdXQgbW9yZSB2aXN1YWxseSBhcHBlYWxpbmc/DQoNCklm
IHRoZXJlIHdhcyBhIElBTkEgZXF1aXZhbGVudCBmb3IgYXNzaWduaW5nIGhlbHBlciBmdW5jdGlv
biBpZCdzIHRoZW4gaXQgbWlnaHQgYmUgcG9zc2libGUgdG8gc3VwcG9ydCBoYXZpbmcgdGhlIHNh
bWUgSURzIG9uIG11bHRpcGxlIHBsYXRmb3JtcywgYnV0IGFzIGl0IGV4aXN0cyB0b2RheSB0aGUg
dmFyaW91cyBwbGF0Zm9ybXMgYXJlIGRldmVsb3BlZCBzZXBhcmF0ZWx5LCB3aXRoIG5vIHNpbXBs
ZSB3YXkgdG8gY28tb3JkaW5hdGUuIFRoZSBiZW5lZml0IG9mIHVzaW5nIHN5bWJvbHMgb3ZlciBu
dW1lcmljIGlkJ3MgaXMgdGhhdCBpdCByZWR1Y2VzIHRoZSBwb3NzaWJpbGl0eSBvZiBpZGVudGlm
aWVyIGNvbGxpc2lvbiwgd2hlcmUgZGlmZmVyZW50IHBsYXRmb3JtcyBtaWdodCBkZWZpbmUgaGVs
cGVyIElEICMgdG8gbWVhbiBkaWZmZXJlbnQgdGhpbmdzLCBidXQgaXQncyBsZXNzIGxpa2VseSB0
aGF0IGRpZmZlcmVudCBwbGF0Zm9ybXMgd2lsbCBkZWZpbmUgYnBmX2Zvb19iYXIgdG8gaGF2ZSBk
aWZmZXJlbnQgc2VtYW50aWNzLg0KDQpDb25jZXB0dWFsbHksIHRoaXMgaXMgbGlrZSB0aGUgcmVs
b2NhdGlvbnMgZG9uZSB1c2luZyBCVEYgZGF0YSBmb3IgQ09SRSwgd2hlcmUgdGhlIG9mZnNldHMg
aW50byBzdHJ1Y3R1cmVzIGNhbiB2YXJ5IGRlcGVuZGluZyBvbiB0aGUga2VybmVsIHZlcnNpb24u
IEluIHRoaXMgc2NlbmFyaW8gdGhlIGhlbHBlciBJRHMgY2FuIHZhcnkgd2l0aCB0aGUgcmVsb2Nh
dGlvbiBiZWluZyBkb25lIGJhc2VkIG9uIHN5bWJvbHMgc3RvcmVkIGluIHRoZSBFTEYgZmlsZS4g
DQoNClJlZ2FyZHMsDQpBbGFuIEpvd2V0dA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogQW5kcmlpIE5ha3J5aWtvIDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiANClNlbnQ6
IFR1ZXNkYXksIE1hcmNoIDgsIDIwMjIgNDo0OSBQTQ0KVG86IEFsYW4gSm93ZXR0IDxBbGFuLkpv
d2V0dEBtaWNyb3NvZnQuY29tPg0KQ2M6IGJwZkB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFtF
WFRFUk5BTF0gUmU6IFtQQVRDSCBicGYtbmV4dF0gU3VwcG9ydCBsb2FkIHRpbWUgYmluZGluZyBv
ZiBicGYtaGVscGVycy4NCg0KT24gVHVlLCBNYXIgOCwgMjAyMiBhdCA5OjIwIEFNIEFsYW4gSm93
ZXR0IDxBbGFuLkpvd2V0dEBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4NCj4gQlBGIGhlbHBlciBm
dW5jdGlvbiBuYW1lcyBhcmUgY29tbW9uIGFjcm9zcyBkaWZmZXJlbnQgcGxhdGZvcm1zLCBidXQg
DQo+IHRoZSBpZCBhc3NpZ25lZCB0byBoZWxwZXIgZnVuY3Rpb25zIG1heSB2YXJ5LiBUaGlzIGNo
YW5nZSBwcm92aWRlcyBhbiANCj4gb3B0aW9uIHRvIGdlbmVyYXRlIGVCUEYgRUxGIGZpbGVzIHdp
dGggcmVsb2NhdGlvbnMgZm9yIGhlbHBlciANCj4gZnVuY3Rpb25zIHdoaWNoIHBlcm1pdHMgcmVz
b2x2aW5nIGhlbHBlciBmdW5jdGlvbiBuYW1lcyB0byBpZHMgYXQgbG9hZCANCj4gdGltZSBpbnN0
ZWFkIG9mIGF0IGNvbXBpbGUgdGltZS4NCj4NCj4gQWRkIGEgbGV2ZWwgb2YgaW5kaXJlY3Rpb24g
dG8gYnBmX2RvYy5weSAoYW5kIGdlbmVyYXRlZCANCj4gYnBmX2hlbHBlcl9kZWZzLmgpIHRvIHBl
cm1pdCBjb21waWxlIHRpbWUgZ2VuZXJhdGlvbiBvZiBicGYtaGVscGVyIA0KPiBmdW5jdGlvbiBk
ZWNsYXJhdGlvbnMgdG8gZmFjaWxpdGF0aW5nIGxhdGUgYmluZGluZyBvZiBicGYtaGVscGVycyB0
byANCj4gaGVscGVyIGlkIGZvciBjYXNlcyB3aGVyZSBkaWZmZXJlbnQgcGxhdGZvcm1zIHVzZSBk
aWZmZXJlbnQgaGVscGVyIA0KPiBpZHMsIGJ1dCB0aGUgc2FtZSBoZWxwZXIgZnVuY3Rpb25zLg0K
Pg0KPiBFeGFtcGxlIHVzZSBjYXNlIHdvdWxkIGJlOg0KPiAiI2RlZmluZSBCUEZfSEVMUEVSKHJl
dHVybl90eXBlLCBuYW1lLCBhcmdzLCBpZCkgXA0KPiAgICAgZXh0ZXJuIHJldHVybl90eXBlIG5h
bWUgYXJncyINCj4NCj4gVG8gZ2VuZXJhdGU6DQo+IGV4dGVybiB2b2lkICogYnBmX21hcF9sb29r
dXBfZWxlbSAodm9pZCAqbWFwLCBjb25zdCB2b2lkICprZXkpOw0KPg0KPiBJbnN0ZWFkIG9mOg0K
PiBzdGF0aWMgdm9pZCAqKCpicGZfbWFwX2xvb2t1cF9lbGVtKSAodm9pZCAqbWFwLCBjb25zdCB2
b2lkICprZXkpIFwNCj4gICAgID0gKHZvaWQqKSAxOw0KPg0KPiBUaGlzIHdvdWxkIHJlc3VsdCBp
biB0aGUgYnBmLWhlbHBlcnMgaGF2aW5nIGV4dGVybmFsIGxpbmthZ2UgYW5kIA0KPiBwZXJtaXQg
bGF0ZSBiaW5kaW5nIG9mIEJQRiBwcm9ncmFtcyB0byBoZWxwZXIgZnVuY3Rpb24gaWRzLg0KPg0K
DQpVZ2guLi4NCg0KQlBGX0hFTFBFUih2b2lkKiwgYnBmX21hcF9sb29rdXBfZWxlbSwgKHZvaWQg
Km1hcCwgY29uc3Qgdm9pZCAqa2V5KSwgMSk7DQoNCkxvb2tzIHByZXR0eSBhd2Z1bCA6KA0KDQpC
dXQgSSBhbHNvIGhhdmUgdGhlIHF1ZXN0aW9uIGFib3V0IHdoeSBkaWZmZXJlbnQgcGxhdGZvcm1z
IHNob3VsZCBoYXZlIGRpZmZlcmVudCBJRHMgZm9yIHRoZSBzYW1lIHN1YnNldCBvZiBCUEYgaGVs
cGVycz8gV291bGRuJ3QgaXQgYmUgYmV0dGVyIHRvIHByZXNlcnZlIElEcyBhY3Jvc3MgcGxhdGZv
cm1zIHRvIHNpbXBsaWZ5IGNyb3NzLXBsYXRmb3JtIEJQRiBvYmplY3QgZmlsZXM/DQoNCldlIGNh
biBwcm9iYWJseSBhbHNvIGRlZmluZSBzb21lIHJhbmdlIGZvciBwbGF0Zm9ybS1zcGVjaWZpYyBC
UEYgaGVscGVycyBzdGFydGluZyBmcm9tIHNvbWUgaGlnaCBJRD8NCg0KPiBTaWduZWQtb2ZmLWJ5
OiBBbGFuIEpvd2V0dCA8YWxhbmpvQG1pY3Jvc29mdC5jb20+DQo+IC0tLQ0KPiAgc2NyaXB0cy9i
cGZfaGVscGVyc19kb2MucHkgfCA4ICsrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9icGZf
aGVscGVyc19kb2MucHkgYi9zY3JpcHRzL2JwZl9oZWxwZXJzX2RvYy5weSANCj4gaW5kZXggODY3
YWRhMjMyODFjLi40NDJiNWU4NzY4N2UgMTAwNzU1DQo+IC0tLSBhL3NjcmlwdHMvYnBmX2hlbHBl
cnNfZG9jLnB5DQo+ICsrKyBiL3NjcmlwdHMvYnBmX2hlbHBlcnNfZG9jLnB5DQo+IEBAIC01MTks
NiArNTE5LDEwIEBAIGNsYXNzIFByaW50ZXJIZWxwZXJzKFByaW50ZXIpOg0KPiAgICAgICAgICBm
b3IgZndkIGluIHNlbGYudHlwZV9md2RzOg0KPiAgICAgICAgICAgICAgcHJpbnQoJyVzOycgJSBm
d2QpDQo+ICAgICAgICAgIHByaW50KCcnKQ0KPiArICAgICAgICBwcmludCgnI2lmbmRlZiBCUEZf
SEVMUEVSJykNCj4gKyAgICAgICAgcHJpbnQoJyNkZWZpbmUgQlBGX0hFTFBFUihyZXR1cm5fdHlw
ZSwgbmFtZSwgYXJncywgaWQpIHN0YXRpYyByZXR1cm5fdHlwZSgqbmFtZSkgYXJncyA9ICh2b2lk
KikgaWQnKQ0KPiArICAgICAgICBwcmludCgnI2VuZGlmJykNCj4gKyAgICAgICAgcHJpbnQoJycp
DQo+DQo+ICAgICAgZGVmIHByaW50X2Zvb3RlcihzZWxmKToNCj4gICAgICAgICAgZm9vdGVyID0g
JycNCj4gQEAgLTU1OCw3ICs1NjIsNyBAQCBjbGFzcyBQcmludGVySGVscGVycyhQcmludGVyKToN
Cj4gICAgICAgICAgICAgICAgICBwcmludCgnICp7fXt9Jy5mb3JtYXQoJyBcdCcgaWYgbGluZSBl
bHNlICcnLCBsaW5lKSkNCj4NCj4gICAgICAgICAgcHJpbnQoJyAqLycpDQo+IC0gICAgICAgIHBy
aW50KCdzdGF0aWMgJXMgJXMoKiVzKSgnICUgKHNlbGYubWFwX3R5cGUocHJvdG9bJ3JldF90eXBl
J10pLA0KPiArICAgICAgICBwcmludCgnQlBGX0hFTFBFUiglcyVzLCAlcywgKCcgJSANCj4gKyAo
c2VsZi5tYXBfdHlwZShwcm90b1sncmV0X3R5cGUnXSksDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHByb3RvWydyZXRfc3RhciddLCBwcm90b1snbmFtZSddKSwgZW5k
PScnKQ0KPiAgICAgICAgICBjb21tYSA9ICcnDQo+ICAgICAgICAgIGZvciBpLCBhIGluIGVudW1l
cmF0ZShwcm90b1snYXJncyddKToNCj4gQEAgLTU3Nyw3ICs1ODEsNyBAQCBjbGFzcyBQcmludGVy
SGVscGVycyhQcmludGVyKToNCj4gICAgICAgICAgICAgIGNvbW1hID0gJywgJw0KPiAgICAgICAg
ICAgICAgcHJpbnQob25lX2FyZywgZW5kPScnKQ0KPg0KPiAtICAgICAgICBwcmludCgnKSA9ICh2
b2lkICopICVkOycgJSBsZW4oc2VsZi5zZWVuX2hlbHBlcnMpKQ0KPiArICAgICAgICBwcmludCgn
KSwgJWQpOycgJSBsZW4oc2VsZi5zZWVuX2hlbHBlcnMpKQ0KPiAgICAgICAgICBwcmludCgnJykN
Cj4NCj4gIA0KPiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQo+ICMjIyMjIyMjIw0KPiAtLQ0KPiAyLjI1LjENCg==
