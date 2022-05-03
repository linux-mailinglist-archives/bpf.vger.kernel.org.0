Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB748518AEC
	for <lists+bpf@lfdr.de>; Tue,  3 May 2022 19:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiECRYL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 May 2022 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbiECRYF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 May 2022 13:24:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32021EEC4
        for <bpf@vger.kernel.org>; Tue,  3 May 2022 10:20:31 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 243HFiX4016700
        for <bpf@vger.kernel.org>; Tue, 3 May 2022 10:20:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=yHWrQRU2g08z7qXAwNeRpE9dkB0WMs4HX+3rLZ/glYU=;
 b=knGnV1khZG5zUwhCLW5FynLQ3T18wXvy9iSHdqL3IChExDx1fyiJUAdtfiqwTDTiThDj
 ClDaLlwIG4Ecboxltn6uixrYXjS3pRGwZV0fO6oEXg1cmQLSfMGpbcPNXEyl2PQmFBXo
 KQsb3XdzbXZS8ViSOnKWYzycj/gqgeh7+JA= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by m0001303.ppops.net (PPS) with ESMTPS id 3fu6sb973r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 03 May 2022 10:20:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUidukZUI3qh/2lsgHFL0bdmFF7m5Rg4mPeTolCGf+dboGZcZ/0TRLrNonku/0rcLPKYl5L1Bt2N+/taISSl8texP+cXvb/pTLarEFWNBwTNqXWPoZllLK3ZsSU/Brtop2rGLpmmyt7IjPs+3Mu5cq068/mHmYwOFMNyjr9hfTntITH8WgtwIiRFSHMrmKiVGaMWoXvL54kvvoGl/mssIpfCmKLjXC+Jw2iYEQtZ+r1ESZeQIUQ0gg0K2fAlfqdgdC4693vdYBZRVLlZJdFuqXk2/atfHgeymVlVv3Mr9nE5Tj1nJrp9YKn1IufUFdQyQaRUVfFcrJJyiDRlvz2xFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qTcrDg3WBo6O0Ce6AUOFufUjBzXihhCkcGW3Toq8Yw=;
 b=LDSPYf2PH3CUenoFQQLFXiu6YiuhQlCcvkcSzuRNwQELrcc7BzFk6DTtWGOK3UO6haYxnBPOVzZzexdNKSrA7Vld1LXBlde6W7zQq5GFEuUJpDJVN9by6bIVb/neDRXagk7Mk5kkx8zLMx/15/E1ceLs6cdSaf7tLn7+N+UvxVRuvrXiXNECgiu7GGqbWMoK1QUntKqMy+rQa4IAJbx0IxwLSuWDNBG03/SHMTGRPsWsvLzUmNbNGN8YG1+YP1J09o4pGUEXxxb/q3tkGzZBWmmwE+QsDVKsTOPpUEQ8MIfx0KkkbErjQkCVA5uatduqeufjx/lQYAf29eBoaSV20A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MN2PR15MB2733.namprd15.prod.outlook.com (2603:10b6:208:126::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 17:20:26 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%5]) with mapi id 15.20.5186.028; Tue, 3 May 2022
 17:20:26 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: implement sleepable uprobes by
 chaining tasks_trace and normal rcu
Thread-Topic: [PATCH bpf-next v2 2/5] bpf: implement sleepable uprobes by
 chaining tasks_trace and normal rcu
Thread-Index: AQHYXnmxxCe8fRcUS0a8mA9+CnJfNq0MscCAgAC0DwA=
Date:   Tue, 3 May 2022 17:20:26 +0000
Message-ID: <c7819d752137cf93be454c117812bb1c2c1866e4.camel@fb.com>
References: <588dd77e9e7424e0abc0e0e624524ef8a2c7b847.1651532419.git.delyank@fb.com>
         <202205031441.1fhDuUQK-lkp@intel.com>
In-Reply-To: <202205031441.1fhDuUQK-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4955af4-df03-4584-6523-08da2d293720
x-ms-traffictypediagnostic: MN2PR15MB2733:EE_
x-microsoft-antispam-prvs: <MN2PR15MB2733A1F8F427E4A94CCF84F8C1C09@MN2PR15MB2733.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r4RN2VLoY2AgRXWYFfrEnWwseJEGNAHBydAHq/0xoFJLOff69M/lmQwF1AFfLrRzBGPsUAIbu/CJam1BLZTU2kQUJbns4CnykQCdq9mGeNVzIOU87x4qYGI6tUQAF5Ozb+lWbQJfxXCRPBon7w7Mlxak6bpcofWB8iolRmqVfFa+YlCJ5+DXeOl69NRETR5oB1mLhTE11VXOxkOs9wV4LQYXnObUB9UUmiqpPXDlzkQOp8sKHI04iPhSU/TKm7cccVKJKtu4E2pP0hnJyo8GnqTGAB3VyDcg2QzXVCN7WOBtQQXHVxEl8SEuokTYg+aGpjQ77toTgIgI2QhG2D6KpCyLenDAfUNfqzCa27xRy8DlSleYuVEm4no7BC8rOCieMspJtafSAI4WbCyIKCzlxGn8bDPbSWE+ey+KTnSVYOH5jN9Dh++kT9DEGxKie4cTiVZnylN1APvChmM4BziBa56j3Nt5upM7yF8GojSeAzqWO/+QIkyJMvQvx+D8XdYMUmVOvGfzh5IBiUEP6aOt9mN5ioIfN92HscfzUzbT/TlyCx8pM140tkB4Lf0KWP2yCv21sasoQTEupm/Hu2yyVjhM8617RhzcMfVlOGJzFLwEw6b9K5pIOAE8R9PDP/YDCilDO/YeLvQPcN54gRWbOAHWL5rCW8pVdFsm4RVC+JfnekL0fhTJ/NZXaYHdkJMXyLEPARQkYi8MEAL5InLIdFQPZhes3isPPNokMqKaR9ua6s6P3EXsLey+IufrfB5yVH7DKoiTkz6tNffldX3rgUblxdA/8QSAg1JjE+05sonzzvRZPj2jsOHVGlrKx8wr72iRPlS9PNjbrM2SbqTxyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(966005)(71200400001)(6506007)(508600001)(6486002)(36756003)(5660300002)(316002)(6512007)(186003)(110136005)(2616005)(38100700002)(122000001)(83380400001)(38070700005)(86362001)(8676002)(66446008)(64756008)(66476007)(66556008)(2906002)(4326008)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWpBdURnU3IzM0J3aFRrdkh1K2RHSU1OdW9SK1JUOGtDSHVTNisxNmNUZWhS?=
 =?utf-8?B?UEZiRTJIdkpTWi9zV1JNQXVEMHpZelMwUTI5SjdYY01WZXBucXpGa2FlZ0t3?=
 =?utf-8?B?MHA2bWpIWC9OYWdKQVBvbmoySm9zVW5vL3d6a01vWnRpZEViZjh2SENMMG5j?=
 =?utf-8?B?ZzBPNlBMUTlFeUNzRkp0bzdqQk8rM3k3N0ZTVmdYUUNPdDEyYm15cnAvb1BR?=
 =?utf-8?B?N2xZenlobkRBUzlSOGxRaXFNSlZXNEhUb0YyU2dMdXY2OVEzVGFaY0Y4SzBn?=
 =?utf-8?B?MVJPd09yVll5TWticVlJY1NDdmpEZGF0NjU2M2ZpZnVQZVFYQ1FJeWdNa2RZ?=
 =?utf-8?B?c21hQXVyWUpJenNxV0RReDl1OHY3bk5UdGhrL0pWeGhubnlOSGtGRnVPNXMr?=
 =?utf-8?B?K0hMWW0zeUdEdER2L0xPUmRJNW1jbVEwV2dESUphY1V5SXNVT2duRHBYaStO?=
 =?utf-8?B?dWdNZTlRYWtZU2dnSCtzSzJhcVZBaDcyeWd3UWk3Y0pHcFp4TnRQK2FlMzY5?=
 =?utf-8?B?WnduUVgxd2Z5QXpON1dER3RuQ05WcktQdEFMRFFVZ1VZTDNjek5aZDBsVWtM?=
 =?utf-8?B?ZTdyS0dsLzQxUzhQUHRiZ2Q3Ykhsa3JyTkhxSHRZNUkvZytSazhCdTl2V2xj?=
 =?utf-8?B?RmJJUDh3T1I5dVgvU0hGajdBU1F2Mmw0bnFqUm5ENXZ4Tk9JK0tGYjcwK29Z?=
 =?utf-8?B?Y3Q3R082K0dSUDRTa0tSc3RoaDZBZjlvbklGbUVjcjRXSUg5dmNuMHhiTFFO?=
 =?utf-8?B?MjBja2FSSEk2R3kzRWEvQnh2L2hEUHBVRGVONDVxSE95Kzc2S05KT2VlN1Vn?=
 =?utf-8?B?U0Y2cExza3Nnek1DK1hlU01BbXpJb1FzUkJhendvMlBZQzhoOXAwS0F2NjFF?=
 =?utf-8?B?L20vQS9BajlIVkhFTWJEVHFBalJ0cWJwNzQxOFA3SUhNTWFVVWZMa3JIY2hE?=
 =?utf-8?B?RitYMTNvdFQrdHR6NnpCZjlzbTJZUFVsY3IrSHpnbEliclBaSkR0bVVGeGFu?=
 =?utf-8?B?SUlyTFRncEZvTHREN3RnYjJNRml6WEkyTjRXOEF0dVgvZmZvWVVuUkQ4d1hy?=
 =?utf-8?B?bnJMSmQzNjA0S1pQQWN2OUJtY3YrTE01c0hhc0cyL25sMEYvNEFad0JHQ0FI?=
 =?utf-8?B?Q041Z1Nib1Q4NXJYZWozOVNwT2JoNnc0QWZhZUJRd0hqUldxeUwwQm1CUmg4?=
 =?utf-8?B?V1N0dTJXUkprQjJRT1pIMXd6ZTA2Rk1hM0QxUmdYNUE1QzhCcVZQYmFtTkFq?=
 =?utf-8?B?WnVGM3NnVDBlVzhGWmJiZW5nOHh1djQvbDBFTjZIYUJwVkpCRDMwcy9GQ0Ix?=
 =?utf-8?B?blBCeVlZQ2dXNERwK2hacXV5NVdXeHprd1Q4NEJQTkpvamNzV0RXUzBLb1E5?=
 =?utf-8?B?T0dIeU4xYUdQaWM4cE5lZjc1QzVqN0hnVVBpNDRhQkdza2YwTnVuY0ZWMmVM?=
 =?utf-8?B?OEZvTFZNWDZyS0YyUkl4c0tTcGw0M2lqSmFWRGR0MGlRRzV0dFltSGFXb25X?=
 =?utf-8?B?YmNPY2NTUUlVaXAwR2JyUlQwZThJUWFsZ3dVVU1GTmtSZVRKQW0wTzRLOHNI?=
 =?utf-8?B?cWNVejJYcThLYWlyMlkwWHVIUTdBc1hnVGFFZ1JjdVJMTnpTSEMzOVBIUXds?=
 =?utf-8?B?cU9HUGF5VTdiVS94NnBBdXJEOTZYRzVQclVtL0hhVXBGL1RZL0ZmVDJjWFJw?=
 =?utf-8?B?ZDlxbkxGWWtsSUYyRWFIMW5xb1dSU1Robm5SUWwyNjNuVzJvSnlWdnNpclBG?=
 =?utf-8?B?Q0hNdzB4ZUxsb1Z0VTR3dVg3QWpUY3FKTy9RTG1qTHpHY3lBK0JYY2hvbEt6?=
 =?utf-8?B?WGpzOUdkQ0hYb1JHdkRkR0VrOXlTYWJBMlU0K1pVRE9iVjArazNZVmF3WVFP?=
 =?utf-8?B?dEtjbmMxUXhoR2JzWEhjcHRzTDBrKzE5aS9ETzNJNThjOXFGZ3ZjaVc4SkRH?=
 =?utf-8?B?SElrWFJJVGlTMjQyRWlEN3dRYW5pbExoQ2JaeU5xOFpxSnFNSXBHVjhNR1Np?=
 =?utf-8?B?MkRUa3EwdjdvVjVlbmRzMFV0NVJLbFVYTEI0TlBoaFhldDNTR1ZsQVMzTjVk?=
 =?utf-8?B?c1JYa3hRZXR3cFovbDNXWXR4NE5jL2ZxNWJPWElXdEoveWtFazJRTVBrRWlP?=
 =?utf-8?B?WDRLeHRuVmZKVmtjbGJ5T2VpeU9pcXB2V3BqT1NzZHlMa0ZOVWw1UjRxMzk2?=
 =?utf-8?B?SmEvREd4YU5MYm9vUUMxdzQrbzdkbkFTbG52QlNENXNDMnA3a0FmeFVNZHFN?=
 =?utf-8?B?NVpmV2FrUkROSEhva2JnK0laUDN6U2ZxMEJ3RnE2NHBBUDhhOHFFTWZndlpZ?=
 =?utf-8?B?U1BGR3JlZlAvTjhuZ25jbkVnREkvZkYrWlI0dW1yeGpCaU9XYUVTNy9mOGVI?=
 =?utf-8?Q?SBsjTV50TIo6ra+U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AD2F4EE93656941ADCD670E50697743@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4955af4-df03-4584-6523-08da2d293720
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 17:20:26.7813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjGPGGZnU4dccc7Hn407ozoxR3U4pUsONVTl/9ofnOOzljCpNdfI7UfgLipY5FfQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2733
X-Proofpoint-ORIG-GUID: 4yGHYI3LhPRNAqEyx1u5CyW3lido6oB6
X-Proofpoint-GUID: 4yGHYI3LhPRNAqEyx1u5CyW3lido6oB6
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-03_07,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTAzIGF0IDE0OjMwICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4gSGkgRGVseWFuLA0KPiANCj4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2ghIFlldCBzb21l
dGhpbmcgdG8gaW1wcm92ZToNCj4gDQo+IFthdXRvIGJ1aWxkIHRlc3QgRVJST1Igb24gYnBmLW5l
eHQvbWFzdGVyXQ0KPiANCj4gdXJsOiAgICBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwtbGFiLWxr
cC9saW51eC9jb21taXRzL0RlbHlhbi1LcmF0dW5vdi9zbGVlcGFibGUtdXByb2JlLXN1cHBvcnQv
MjAyMjA1MDMtMDcxMjQ3DQo+IGJhc2U6ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvYnBmL2JwZi1uZXh0LmdpdCBtYXN0ZXINCj4gY29uZmlnOiBpMzg2
LWRlZmNvbmZpZyAoaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjIw
NTAzLzIwMjIwNTAzMTQ0MS4xZmhEdVVRSy1sa3BAaW50ZWwuY29tL2NvbmZpZyApDQo+IGNvbXBp
bGVyOiBnY2MtMTEgKERlYmlhbiAxMS4yLjAtMjApIDExLjIuMA0KPiByZXByb2R1Y2UgKHRoaXMg
aXMgYSBXPTEgYnVpbGQpOg0KPiAgICAgICAgICMgaHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxh
Yi1sa3AvbGludXgvY29tbWl0L2NmYTBmMTE0ODI5OTAyYjU3OWRhMTZkNzUyMGEzOTMxNzkwNWM1
MDINCj4gICAgICAgICBnaXQgcmVtb3RlIGFkZCBsaW51eC1yZXZpZXcgaHR0cHM6Ly9naXRodWIu
Y29tL2ludGVsLWxhYi1sa3AvbGludXgNCj4gICAgICAgICBnaXQgZmV0Y2ggLS1uby10YWdzIGxp
bnV4LXJldmlldyBEZWx5YW4tS3JhdHVub3Yvc2xlZXBhYmxlLXVwcm9iZS1zdXBwb3J0LzIwMjIw
NTAzLTA3MTI0Nw0KPiAgICAgICAgIGdpdCBjaGVja291dCBjZmEwZjExNDgyOTkwMmI1NzlkYTE2
ZDc1MjBhMzkzMTc5MDVjNTAyDQo+ICAgICAgICAgIyBzYXZlIHRoZSBjb25maWcgZmlsZQ0KPiAg
ICAgICAgIG1rZGlyIGJ1aWxkX2RpciAmJiBjcCBjb25maWcgYnVpbGRfZGlyLy5jb25maWcNCj4g
ICAgICAgICBtYWtlIFc9MSBPPWJ1aWxkX2RpciBBUkNIPWkzODYgU0hFTEw9L2Jpbi9iYXNoDQo+
IA0KPiBJZiB5b3UgZml4IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFnIGFzIGFw
cHJvcHJpYXRlDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNv
bT4NCj4gDQo+IEFsbCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4gDQo+ICAg
IGtlcm5lbC90cmFjZS90cmFjZV91cHJvYmUuYzogSW4gZnVuY3Rpb24gJ19fdXByb2JlX3BlcmZf
ZnVuYyc6DQo+ID4gPiBrZXJuZWwvdHJhY2UvdHJhY2VfdXByb2JlLmM6MTM0OToyMzogZXJyb3I6
IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICd1cHJvYmVfY2FsbF9icGYnOyBkaWQg
eW91IG1lYW4gJ3RyYWNlX2NhbGxfYnBmJz8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVj
bGFyYXRpb25dDQo+ICAgICAxMzQ5IHwgICAgICAgICAgICAgICAgIHJldCA9IHVwcm9iZV9jYWxs
X2JwZihjYWxsLCByZWdzKTsNCj4gICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgXn5+
fn5+fn5+fn5+fn5+DQo+ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIHRyYWNlX2Nh
bGxfYnBmDQo+ICAgIGNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycw0K
DQpIbSwgQ09ORklHX0JQRl9FVkVOVFMgZG9lc24ndCBzZWVtIHRvIGd1YXJkIHRoZSBjYWxsc2l0
ZSBmcm9tIHRyYWNlX3Vwcm9iZS5jLCBpdCdzDQpvbmx5IGdhdGVkIGJ5IENPTkZJR19QRVJGX0VW
RU5UUyB0aGVyZS4gQSBQRVJGX0VWRU5UUz15ICYmIEJQRl9FVkVOVFM9biBjb25maWcgd291bGQN
CmxlYWQgdG8gdGhpcyBlcnJvci7CoA0KDQpUaGlzIGlzICBhIHByZS1leGlzdGluZyBpc3N1ZSBh
bmQgSSdsbCBzZW5kIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIGl0Lg0K
