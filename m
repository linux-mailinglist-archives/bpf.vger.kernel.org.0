Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6695A7338
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 03:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiHaBLB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 21:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHaBLA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 21:11:00 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA274F666
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 18:10:59 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V0qaNA025393
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 18:10:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cuSLf3MsODz8hUOEp7dTkfs8mOnQ0DqmcwAXVYkLEXw=;
 b=ZUHtNbyqNRrn8U3OoKor8P0lGe1ib5W2ypSy6Jk3C1bLI+Izr4BZJ1TVM3a1CkO7IbxK
 8nEFyMZwzwA2PQ9b9yLmOXxK0uFU3gx+zKb1qH4jzeN54iB2G2ExOvpYtU1VO2L+pFwC
 NKGOsCwY6E2IS5tIZ+/vG/wDcqBIBrOAY9c= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9ae4enys-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 18:10:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STw+NSrKY8ojZOA9tMhrFlJXWH40xb/LtnjCn8H71dhM2qqJo4PxFDDUvbTBqYN99lVGVCweoD/w8PMJ8BdGxXuxqZ7Zv/YuzbK4Zy2zoKTAgeh+rvgjRgJyV80AvETEZ6ZJiorThzNTIu5HnefO5VSlS0sefeVuePFtwAPD5Eww9r3XIACJ6MhzRRsZiUVImrPbI/9DJZ64k/leMnJQayX4dWimktbPiK5riaaNSUzMMM7GLOcmJHKIPcmRt+pmnNW+zr8f53sYGodJQvTirJoQ2/Hg/Qhvb1mMgBlReifm2Vf5APd7UswLWrDQtHrZCLruFC+Uih7JhcYDJUJXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuSLf3MsODz8hUOEp7dTkfs8mOnQ0DqmcwAXVYkLEXw=;
 b=CDDlX5CiIR+D+LMmbY9bRYfn090b9Gvs3lfvFmEaxm0OKcVkxvaTA6z9r5ICGHIsBbNH2JPzrIjZ3VSUfF9TfyMKSbN+OLuzb6uYgtkFJVE8UbSn+J3cxDkMBpA3K3SvtJLuguKsJSkq0x2dabSU9xeZmcbFAjSMGe2HvD4LCLnGjptEw5D1UtmlLzsqw9+zHaLWK5zGFGgFm7yP7uwjxdSxZ6E9CkXWv1CQ5S4o9FLoN6GZHxNX6QLTSqD2Jdibr0vDa8Mj64I1tuMUGUXeErAbuVodR8kn+bFKvhfzXgeI30rM3LfShurpBY1deqS5Sd6MC2cxJEbIZO1num/BQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by MN2PR15MB3360.namprd15.prod.outlook.com (2603:10b6:208:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 01:10:56 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8fb:578:a3da:40ce]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8fb:578:a3da:40ce%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 01:10:55 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "haoluo@google.com" <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "quentin@isovalent.com" <quentin@isovalent.com>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 5/5] bpftool: Show parameters of BPF task
 iterators.
Thread-Topic: [PATCH bpf-next v8 5/5] bpftool: Show parameters of BPF task
 iterators.
Thread-Index: AQHYu9zdKf5FVjH530y9Tzu2bSbSsq3HqfqAgACLVQA=
Date:   Wed, 31 Aug 2022 01:10:55 +0000
Message-ID: <508313c3fd5b87263c7b9eb575bdde97f90eef47.camel@fb.com>
References: <20220829192317.486946-1-kuifeng@fb.com>
         <20220829192317.486946-6-kuifeng@fb.com>
         <1b14efc0-a292-30f4-c94b-207b40818e86@isovalent.com>
In-Reply-To: <1b14efc0-a292-30f4-c94b-207b40818e86@isovalent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 620d0441-d57d-4b21-7f8c-08da8aeda81b
x-ms-traffictypediagnostic: MN2PR15MB3360:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GslZ3CPkzcBRLbvNrI76jkQSgRPzAPLTHiXo5smlCZ0S5MLl85fxA3XCr2wCFmN5yvpvWESlynFqC+mn9Zq+Bxf8MBMmbSvIJTBb6eB8HaD+vyTuPkvmfH5FWrHq9hzMa/KYfvE6/RnDPXGqUmH2qDVuw+uCONC3zya+bJPvkN1jrAWpknp9Vd48Iu7QOttUv5X3ia3FmPtyfvzcdXzvXxVvQEI0v5ahZRlRZeWFD+UwNumW0DWZzo0V1ePZhgvhXkAhM0XWMtR+yY3+Fq1hYyKPhNHvWNbJXBwXbmw8LEza+VY4UNn8CCEh3YoGuAdzoX7nRFh5FaKiSOMEaiA3NIlelWGwUZ3H/wM66uwZAbfapPni5bTadRyAb7P5JkxQmzMUL84hqen68BTUIB8/cOTdnnWD4uRTFrLxNjZFtwhaj0pr+vH/5bxV/hX/x0OnEkVgRaZb5sC0grahS8hnTYsYkddqidXC4l8lhIhNvhoRSuQ4YHK5L85BQyxYRbF9aoomXeoyIWm+4ztHEVMKTE+FDONenkpFtcak3Nd4lMsQNlu3yJeJxnjpwhzmcKZYQ44uq/35f9XSk4Dwpj8dIXWYbUPXx9kBEaBtT34nfP7vgXs5U/lA7azVx1LMPY4W+Ikz5cPeReGGSqrL5ib6xbF4W4naWZVVG0MITeE7zssN9a+sxdPXNaU6SRDXNBPmFAlWojo14pH8Rm7AGqrn+49qEKa3cuoBgAa16D0j97HQcLrMTvxJ2aNcvZpa7p0ReenYVsFSxQ7AFmjW5KWE/KFSBgTpWuQQexEaKF1ffNE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(71200400001)(36756003)(8676002)(8936002)(76116006)(316002)(110136005)(186003)(6506007)(66556008)(64756008)(66446008)(66476007)(66946007)(6512007)(478600001)(122000001)(38100700002)(6486002)(966005)(83380400001)(41300700001)(5660300002)(86362001)(2616005)(38070700005)(2906002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RndqSmZPVmt1Nm1Yb2ZTVmVrd0MrMldhV0NONVQvVzZnazNiZXpZcUNwU1dn?=
 =?utf-8?B?WEJDKzUxbU1oQnNRV1NtY0xSWEJ1UzJRNjdlc3VBVlFDTndnY3dLTzh5c29Z?=
 =?utf-8?B?ZjAwcytja0hQbHRYYXRVcHkyTHB3QVhHbzdRcDhwWGJrZ0t2bS82ZWRnL25K?=
 =?utf-8?B?bmFjQnBBS0hRV0pNU2JJVHc0ejk3dGFsdTRxZVcxUEtoaDl3ZnpGRjlueDg1?=
 =?utf-8?B?TERPc3dSYzFvZDlPQW1EYlcvQmQveXpNaE9GcnJ6eTg2SnR0b0pIRWRFTFN1?=
 =?utf-8?B?ZjNwV1MrOFBqYXQ0c1J1WmZmWXQ2bTNyZnhxM0dOUWd2ckJVYTZaakVEc0Jt?=
 =?utf-8?B?OGhabkVWOWxnTmE2Z0x3L2NielZEOHlScXZtQzZmQWViMUcvTVFwWnpVSzVt?=
 =?utf-8?B?TGJUSnBiTjZoaWNhS1dSQlFhakxqZ3ViblNVNm1RL05HckFuMnRZSHlLU3dB?=
 =?utf-8?B?MjNjcDAvem95aVgrd1h1ODZNa2pnRHZia04vZ2duc0dFeGJnV3A2QkFnZ3pP?=
 =?utf-8?B?WFFLNFNkR1RHd2xDeXBWd3NESUUxNUtLU1JpVGpreGlNWjBkYktmL04yUWJj?=
 =?utf-8?B?WVVoZVdOUXUxS1RFclZ4bkcxZ3NlYWl4TGRDVzF4MlFnTzhMTWhuQ0VnOEpn?=
 =?utf-8?B?OTZ5WENOSzBYTnJHcjFxV1FzQy96Qk9qMndBYVNRdjk3THhoN1BhWDdFa1p5?=
 =?utf-8?B?Q3ZrZ1Y5UHBjRE5VTWtnMWxCMnhyMEVtQ1NtKzhSTnJLdk16VlVMYktoN21H?=
 =?utf-8?B?cmlJTUFiWWVUSHphbTdneGQ3TSszSUVPNUV1ZU1YZDNEaWt2ckNUSlZLUmtw?=
 =?utf-8?B?b1pVM3hVTHh3WE5MbGorUzJ0blVJTCs2cmllNmNubm9LYmhMZm84N1JyRU9T?=
 =?utf-8?B?VFlPTFRNeStGcmxFOWFsNHllL0xJUnY2ekdRMk9XVXJPZFBjbWR2UGZ5YWxq?=
 =?utf-8?B?Z0pPbDJ1TE02aUkxM2pEMUE1QnY2L2cyVWw1VDhrM0RQN2lRK0xIakYwZUVX?=
 =?utf-8?B?NzNrbmRkQW1QZ3A2UGtBTGZTU2F3SHJmZUNmMXRNWlAxb1l4aEw4WlhKVmhU?=
 =?utf-8?B?bGp6WW5zbXlFdGpwMXpFdzVjWUZRekRXUks5Rm9SR0Y0YU1yRjVXdEZiY0xz?=
 =?utf-8?B?UHhMWTNOd3hQbmlKUVNycFl4UlAybmoxLzduYitBblpoUVR3eWc5VXRTMTFJ?=
 =?utf-8?B?VWZRcDVGT09WbG96UzBQTUN3cmxyL3pYSzNZMFZvcUcvOVhiS3BISGgzR016?=
 =?utf-8?B?YUhHMGU3WjllY3lGMjZac2ZuaUhCUjQ4Q3BSOFNWVVYvSmNtNzZZdkhDa0tt?=
 =?utf-8?B?N2ZWQzFYeFFyRmJiYXh5UlliTEt2cUxGN0RUbDM0WENoVXg4SFF1QTE2dURB?=
 =?utf-8?B?MEIyOWRJOFE2UWllNmRMU3dhS1Z5b3VuRUdvRDdlUVByeUZtZXlzSEJ1a3N4?=
 =?utf-8?B?T2ViN3dudHg2ZGpMenhuRExxRkpZd01pVEV4VlA1eC8vM05jN3JrNVNlUnJN?=
 =?utf-8?B?UlFTYkFUMWJYRnBGS1d2K09vKzY5c1lhRGlyWmNDWWFpRnpQTFNHSGxHQ0cy?=
 =?utf-8?B?UUJsNUJMS0tuMEpkdWdNb29TbzhraU9IQ3dXdlIyZW9DNWN3dTdYbUE0ZFgr?=
 =?utf-8?B?OGFqT2x4Ry94L0lkcldzU1JPOVAyWXpJMGszbnRMSjdNcTVDR1RmamNJQ2Uv?=
 =?utf-8?B?UDBZUlVEUGxaWFF1YytDdFcxWTRtUVNza0xWVGY4aVA1MVZJZ3FTK3UxYVBD?=
 =?utf-8?B?bHpubVVPVld4TTBzdmhXRUIrdXZsd1BwMUZNcCtOVlhHK0RLc2xodjlCMGVv?=
 =?utf-8?B?ZVJaRGxRSjl2QUpURXRrS1I0M3JQbVhWekdEalNERGl4Y3QyNzVsTjYwR2Fv?=
 =?utf-8?B?OEwvVXIydTZBNC9wcnZFS29WSVZibm1lL0l0VEYvTDc5RlBoYVVLRE9vSWIv?=
 =?utf-8?B?V1VwWTR5akk3dlVwd2ZJbXFRbmJiNy9NRXUvaEdDWm1yRFVCdjAvY3c5b09y?=
 =?utf-8?B?SFNqN2lvcFF3T0JlZ0hrdXRMQ2lHNG9EZTg5WlJkZkxjdG13NVpzWWdpY01w?=
 =?utf-8?B?ODBVYURTS25MMzVNRytnOVJ5UzU1K2R1MlNxNUN1SVY5RXVGeWUyaGhPckxX?=
 =?utf-8?B?dndjQTJmcVI5eVBvYTBQNTRMUEcwT1JaaUFjbmZUd0J6YVdNakZqNURSenZ5?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A2785856A358B4CA1654F21F9A630E5@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620d0441-d57d-4b21-7f8c-08da8aeda81b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 01:10:55.8134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1o5zb6icNioLbLU/vRPrTYYJVSChPGtfzgRdt54Z9uSOMeYWAMuXVM133gSNAUbl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3360
X-Proofpoint-ORIG-GUID: 4xYDorKJcGSYFG-pVDHw8XwcyF3ZSR72
X-Proofpoint-GUID: 4xYDorKJcGSYFG-pVDHw8XwcyF3ZSR72
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_01,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTMwIGF0IDE3OjUyICswMTAwLCBRdWVudGluIE1vbm5ldCB3cm90ZToK
PiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLXwKPiDCoCBUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5k
ZXIKPiAKPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ICEKPiAKPiBPbiAyOS8wOC8yMDIyIDIwOjIzLCBLdWkt
RmVuZyBMZWUgd3JvdGU6Cj4gPiBTaG93IHRpZCBvciBwaWQgb2YgaXRlcmF0b3JzIGlmIGdpdmlu
ZyBhbiBhcmd1bWVudCBvZiB0aWQgb3IgcGlkCj4gPiAKPiA+IEZvciBleGFtcGxlLCB0aGUgY29t
bWFuZCBgYnBmdG9vbCBsaW5rIGxpc3RgIG1heSBsaXN0IGZvbGxvd2luZwo+ID4gbGluZXMuCj4g
PiAKPiA+IDE6IGl0ZXLCoCBwcm9nIDLCoCB0YXJnZXRfbmFtZSBicGZfbWFwCj4gPiAyOiBpdGVy
wqAgcHJvZyAzwqAgdGFyZ2V0X25hbWUgYnBmX3Byb2cKPiA+IDMzOiBpdGVywqAgcHJvZyAyMjXC
oCB0YXJnZXRfbmFtZSB0YXNrX2ZpbGXCoCB0aWQgMTY0NAo+ID4gwqDCoMKgwqDCoMKgwqAgcGlk
cyB0ZXN0X3Byb2dzKDE2NDQpCj4gPiAKPiA+IExpbmsgMzMgaXMgYSB0YXNrX2ZpbGUgaXRlcmF0
b3Igd2l0aCB0aWQgMTY0NC7CoCBGb3Igbm93LCBvbmx5Cj4gPiB0YXJnZXRzCj4gPiBvZiB0YXNr
LCB0YXNrX2ZpbGUgYW5kIHRhc2tfdm1hIG1heSBiZSB3aXRoIHRpZCBvciBwaWQgdG8gZmlsdGVy
Cj4gPiBvdXQKPiA+IHRhc2tzIG90aGVyIHRoYW4gdGhvc2UgYmVsb25naW5nIHRvIGEgcHJvY2Vz
cyAocGlkKSBvciBhIHRocmVhZAo+ID4gKHRpZCkuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEt1
aS1GZW5nIExlZSA8a3VpZmVuZ0BmYi5jb20+Cj4gPiAtLS0KPiA+IMKgdG9vbHMvYnBmL2JwZnRv
b2wvbGluay5jIHwgMTkgKysrKysrKysrKysrKysrKysrKwo+ID4gwqAxIGZpbGUgY2hhbmdlZCwg
MTkgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvYnBmL2JwZnRvb2wv
bGluay5jIGIvdG9vbHMvYnBmL2JwZnRvb2wvbGluay5jCj4gPiBpbmRleCA3YTIwOTMxYzMyNTAu
Ljg4OTM3MDM2ZmFlMCAxMDA2NDQKPiA+IC0tLSBhL3Rvb2xzL2JwZi9icGZ0b29sL2xpbmsuYwo+
ID4gKysrIGIvdG9vbHMvYnBmL2JwZnRvb2wvbGluay5jCj4gPiBAQCAtODMsNiArODMsMTMgQEAg
c3RhdGljIGJvb2wgaXNfaXRlcl9tYXBfdGFyZ2V0KGNvbnN0IGNoYXIKPiA+ICp0YXJnZXRfbmFt
ZSkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RyY21wKHRhcmdldF9uYW1lLCAi
YnBmX3NrX3N0b3JhZ2VfbWFwIikgPT0gMDsKPiA+IMKgfQo+ID4gwqAKPiA+ICtzdGF0aWMgYm9v
bCBpc19pdGVyX3Rhc2tfdGFyZ2V0KGNvbnN0IGNoYXIgKnRhcmdldF9uYW1lKQo+ID4gK3sKPiA+
ICvCoMKgwqDCoMKgwqDCoHJldHVybiBzdHJjbXAodGFyZ2V0X25hbWUsICJ0YXNrIikgPT0gMCB8
fAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cmNtcCh0YXJnZXRfbmFtZSwg
InRhc2tfZmlsZSIpID09IDAgfHwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBz
dHJjbXAodGFyZ2V0X25hbWUsICJ0YXNrX3ZtYSIpID09IDA7Cj4gPiArfQo+ID4gKwo+ID4gwqBz
dGF0aWMgdm9pZCBzaG93X2l0ZXJfanNvbihzdHJ1Y3QgYnBmX2xpbmtfaW5mbyAqaW5mbywKPiA+
IGpzb25fd3JpdGVyX3QgKnd0cikKPiA+IMKgewo+ID4gwqDCoMKgwqDCoMKgwqDCoGNvbnN0IGNo
YXIgKnRhcmdldF9uYW1lID0gdTY0X3RvX3B0cihpbmZvLQo+ID4gPml0ZXIudGFyZ2V0X25hbWUp
Owo+ID4gQEAgLTkxLDYgKzk4LDEyIEBAIHN0YXRpYyB2b2lkIHNob3dfaXRlcl9qc29uKHN0cnVj
dCBicGZfbGlua19pbmZvCj4gPiAqaW5mbywganNvbl93cml0ZXJfdCAqd3RyKQo+ID4gwqAKPiA+
IMKgwqDCoMKgwqDCoMKgwqBpZiAoaXNfaXRlcl9tYXBfdGFyZ2V0KHRhcmdldF9uYW1lKSkKPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKganNvbndfdWludF9maWVsZCh3dHIsICJt
YXBfaWQiLCBpbmZvLQo+ID4gPml0ZXIubWFwLm1hcF9pZCk7Cj4gPiArwqDCoMKgwqDCoMKgwqBl
bHNlIGlmIChpc19pdGVyX3Rhc2tfdGFyZ2V0KHRhcmdldF9uYW1lKSkgewo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChpbmZvLT5pdGVyLnRhc2sudGlkKQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBqc29ud191aW50X2ZpZWxk
KHd0ciwgInRpZCIsIGluZm8tCj4gPiA+aXRlci50YXNrLnRpZCk7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZWxzZSBpZiAoaW5mby0+aXRlci50YXNrLnBpZCkKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKganNvbndfdWludF9maWVs
ZCh3dHIsICJwaWQiLCBpbmZvLQo+ID4gPml0ZXIudGFzay5waWQpOwo+ID4gK8KgwqDCoMKgwqDC
oMKgfQo+ID4gwqB9Cj4gPiDCoAo+ID4gwqBzdGF0aWMgaW50IGdldF9wcm9nX2luZm8oaW50IHBy
b2dfaWQsIHN0cnVjdCBicGZfcHJvZ19pbmZvICppbmZvKQo+ID4gQEAgLTIwOCw2ICsyMjEsMTIg
QEAgc3RhdGljIHZvaWQgc2hvd19pdGVyX3BsYWluKHN0cnVjdAo+ID4gYnBmX2xpbmtfaW5mbyAq
aW5mbykKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGlzX2l0ZXJfbWFwX3RhcmdldCh0
YXJnZXRfbmFtZSkpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByaW50Zigi
bWFwX2lkICV1wqAgIiwgaW5mby0+aXRlci5tYXAubWFwX2lkKTsKPiA+ICvCoMKgwqDCoMKgwqDC
oGVsc2UgaWYgKGlzX2l0ZXJfdGFza190YXJnZXQodGFyZ2V0X25hbWUpKSB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGluZm8tPml0ZXIudGFzay50aWQpCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByaW50ZigidGlkICV1
ICIsIGluZm8tPml0ZXIudGFzay50aWQpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGVsc2UgaWYgKGluZm8tPml0ZXIudGFzay5waWQpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByaW50ZigicGlkICV1ICIsIGluZm8tPml0ZXIu
dGFzay5waWQpOwo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gwqB9Cj4gPiDCoAo+ID4gwqBzdGF0
aWMgaW50IHNob3dfbGlua19jbG9zZV9wbGFpbihpbnQgZmQsIHN0cnVjdCBicGZfbGlua19pbmZv
Cj4gPiAqaW5mbykKPiAKPiBBY2tlZC1ieTogUXVlbnRpbiBNb25uZXQgPHF1ZW50aW5AaXNvdmFs
ZW50LmNvbT4KPiAKPiBMb29rcyBnb29kIHRvIG1lLCBhbHRob3VnaCB0aGlzIHBhdGNoIG1heSBj
b25mbGljdCB3aXRoCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYnBmLzIwMjIwODI5MjMxODI4
LjEwMTY4MzUtMS1oYW9sdW9AZ29vZ2xlLmNvbS90LyN1CgpUaGFua3MhICBJIHdpbGwgcmViYXNl
IHRoZSBjb2RlLgoK
