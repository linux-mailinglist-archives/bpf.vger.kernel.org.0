Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF94B19C9
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 00:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244555AbiBJXs6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 18:48:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345880AbiBJXs6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 18:48:58 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A385F7B
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:48:58 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ANSJqC010640
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:48:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=w+0YrIIsqm0X8MBswaMSHv09mzbYICz5w9lAoP5sp2I=;
 b=jDQRPVZ03YeqnjjzypExqDryvaJc5cMstaew7goYX0XenW9uH68bGrnWakZyb2Aq7Iu5
 W89iHeD1AKjn4O+c/Xq1LIPMnqSNUelL8lS4VFohwG5fho9ZoV4fT/4Eu3RsPNcLHdgk
 b+03mEOXFdZscQaTMxU0m0A59NY9ET+h9DM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e58e1hydb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:48:56 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 15:48:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRfNZxiwW5qagAh4FivF+dGQjGtgHT8pI1ya2LNnvmHSNHFcGmvh4g+68IXWfQd974Gmyvv8BvmVvgLDAE1eOR4PRzu0eUY0eAqezn7GOs+kLp1pzmAuQsHBh3i3YBSdf27NDzVXuDbNE4noLgALvbo+unVWg5Xs1tqnJp08ig4RrCR/hYsoioL+La846arYFpimK57B6BrHkKms/8cF52mM+K3xIakw5/AOqrtJJruAXLa+6qkkHddj6rNJ4OEvrCwd+pNozRyeowZVXLXNuKL/8CBxmyYvNkbHn+ZgH+5p1rLvguyDxt7EDvZoaE/9BHMm18FuS3pcoNuAfz31iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+0YrIIsqm0X8MBswaMSHv09mzbYICz5w9lAoP5sp2I=;
 b=jxJ5/YpHX2J662bc7zlnkkMCUm1DmNBh0WPxXhdLjzsgr/ULh9JalU3NSVRH2Es76PehCiMWhvooFMKiYIBQ6Kacl8MuLJp/XvfLcqmpg35gus1e5JMiYNB90tAu3yRhouV9sk3pb77WVv0tNJhW7zxyIGQj+UIwnn65zkIQRcTScp6qcjrldR9h3/kIBr7CikhFIS3b5OSNZ2cKSzPReJUVFnRpJnB9s2ZXS+zFcDblhEs8Y2ia99dpNx2GqlBvrdgOnNEbp2pU8YoF4XiiPp3vRJD4V6/H4UTh3HvyQI2cSGHAUz3cGBeqzMyrefCWT5/XZjQetMT68sVBtmb4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by SN6PR15MB2509.namprd15.prod.outlook.com (2603:10b6:805:1a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 23:48:41 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7%5]) with mapi id 15.20.4975.012; Thu, 10 Feb 2022
 23:48:41 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: add test case for
 userspace and bpf type size mismatch
Thread-Topic: [PATCH bpf-next v1 3/3] selftests/bpf: add test case for
 userspace and bpf type size mismatch
Thread-Index: AQHYHhZMpB6mFfupCUubIQLMBsXF76yNY1eAgAAQg4A=
Date:   Thu, 10 Feb 2022 23:48:41 +0000
Message-ID: <e26b4756cbd3cb1f59fbd3a410f1eb3117f020c4.camel@fb.com>
References: <cover.1644453291.git.delyank@fb.com>
         <dcb8cfcd9946a937b8d4a93b9c42eaf3aad54038.1644453291.git.delyank@fb.com>
         <CAEf4BzbJvZyAfdY4+kFSBzBv=-dXQU=2Y7EfjwnTB++d_b=SJA@mail.gmail.com>
In-Reply-To: <CAEf4BzbJvZyAfdY4+kFSBzBv=-dXQU=2Y7EfjwnTB++d_b=SJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61d20f28-c22f-4904-b6b6-08d9ecefde29
x-ms-traffictypediagnostic: SN6PR15MB2509:EE_
x-microsoft-antispam-prvs: <SN6PR15MB2509C777198BF64BB91736DBC12F9@SN6PR15MB2509.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F/nvSR9OdLQ4WSvraGp4SD775YVtmt3k8xHiDJmKfe/fDXG4tNa88DTKU1oZ8e2vawS1xiLcqM5bhbRGvTFMr8h5mBL15Uz+vePd1/qCFP2ncsgdOg5DyYKmkH59/xdJu5nj+kWWDL5621MPisyzGvepk5ai0pf5OndIbrWV2F5Chlc50MAopjrid/AIT0FkKTxSKMMaj4YudycrjN1k9xxH1iVb3lJtDhiz4nbPkg7m0kMedKDjzELY1Sln9S5yFbHqjd3EOGix2JyuNfjcBRft116venj1hgQX5+dvezainPwrZbQ9onr43y4UGdiyhhGg6clRUpjXQO/YDprv1IIEVNa8q4ykd3o8tP9EifadMDqMK51aKUMpnYHj44YF/rPDMqdEwzgEojUO8IGkH5fQ5qObQbAj3gwRjzumqFVraaACg+tBpaTlbeL0vRcaXzNecf7YhbW/gZTENKlKrnUHgBJkr/gzMOHw33aEjA/A6hvWJhbTww8jspowDKgCftwbbakXLs/Wk7XtMLvRR0qLQZlDWGXcbiIwkED09HdYWHKe2s2AscwRSJ/ynsdssZ29Cj1jpQvZqN++yrWFi7xplUAiFau3NX+cVBseHYecMHqmdOZDj1XOw5//aG8qgFmFgYZfKoXMBIdtUt0lNsFq9Zx+3y7HnRKR16ZgbRsHgEuQy9lmFnWalo709DGOinYkm0Q1X10xhUKPhV9rsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(4744005)(122000001)(2616005)(38100700002)(36756003)(186003)(38070700005)(76116006)(316002)(6916009)(54906003)(8676002)(8936002)(64756008)(66446008)(66946007)(6486002)(86362001)(6506007)(91956017)(6512007)(508600001)(5660300002)(66556008)(66476007)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHpVUXNxbENrTUdnemVPY0tqQ1lvS3pmcEMzK0lSd1RZd3hlN2JiRWc3WTFL?=
 =?utf-8?B?ai9ySzRlMTVPN1hRbllWMUN6OUFCKy82U05PQVRoZ0Uwd1ZxUFJzTU4rMTk2?=
 =?utf-8?B?NnpaK25odFJlUXVxZTVGZ1l6b29xSllYQ2VIdUMzaHlQRWIxUTJvalk0L2xX?=
 =?utf-8?B?SGZSaDhNM1ZBemRpZnRLSVFRQU1lSmVhdDFzaEhhMVgxdjRrOW5YYnYwUFNL?=
 =?utf-8?B?Zjd6enFaWXVNc0tHUndEd3dDd0FNajI3Ni93RFF0Q3A0Q0l0Ny9YT05vUEEx?=
 =?utf-8?B?WHRZdlltMUFDZ3JreGxJbElXVCtETEZwTUI1ZU84V3JxVWdLNEVLUFNNZDkz?=
 =?utf-8?B?dmdwcjVRMVhGSlRYTXc2UGFKWDdLRUsyeWE3U3I0b3lhWno3ZitJR3FCT3hY?=
 =?utf-8?B?ZHgrRFdUclhlNFVObDlhSVVUMFBMVTZLZG54Ym9kTHRqSFNHU29selgrRXUv?=
 =?utf-8?B?OHFzeHN3bHJMdmo4UTZTbHZBcDBMT0xYQ2hNSUxPNG9jbDBpL28vcDB3RDFF?=
 =?utf-8?B?T0JiZ214YjR4ZXRYZFV3UFMzRjMvbWoxLzluYTdsNVlKdERMTkc4MFRCakI2?=
 =?utf-8?B?dUF1elFJVytaSXRJYnd2c2Zjbzh5MGtKWlF4bWJOU20yUzZyNFhRM2RmbGZx?=
 =?utf-8?B?Uzl6TlJwNU5nK0NqVGxaS0ozV3pXYk9reGltbDNsaWV2cHFDWllDSGFnZlVO?=
 =?utf-8?B?aWsreklPOE03WUZnaCtLWWNzd0dvOEFUR244YXMzdllEM3lVOHV3WWFaRVl1?=
 =?utf-8?B?VFpNU2xtYnZ6VlJMZnVIWGxHYWpNR2lySkFCdjB2SE1mK2J1SXZLUnZMUUJJ?=
 =?utf-8?B?MmNmM3MwM2FVSVR1MlhXZDZjb25Nd2JPYVNlN1ByQ1RvaWNFVVJseGd1bDlv?=
 =?utf-8?B?eFJNemRDVHozdXB1Y0Y3NGFDN1M2TFlvVHo0WUJFRWsycWlaWFRVSGI2S25E?=
 =?utf-8?B?M0hHZ3A0SzNZNXNMS2szbWI2eFdnNlNkTkJsZjBPWW5UU2dhQWxXSXRFQzBC?=
 =?utf-8?B?T2pMN2NuUVhkSnhkKzNLMUVsT0Y5dHhwUVl3bk5uOXZSWFdNdEJpMHh5M3VH?=
 =?utf-8?B?MStERnUvRytEdnA1TGVoNXl0TU01RXRmWjdjZVNveWlCYWVYbmJSaHlYT0lX?=
 =?utf-8?B?Z29CS2tTMGhrTWUxWFZNWk1wL3ZBZUh6ZnNRUW1GY2EwTHQzd0tHY0ZtbzMz?=
 =?utf-8?B?MWpaSFBrRGZqU1FnMUJMQStONENVd2ZQRGZGdmVJVm1iOFQ0VGhSV2c3dGtm?=
 =?utf-8?B?c3U3UmV5Q014U1pYeEMyYXlkK2NJMHVMZ2pVNnVSTVlJdU4yL0puQXdOYWNn?=
 =?utf-8?B?SFN6OTdPNVJ2bENGYjY5ampuR25DTGwya3dOVXB1MWZmMWtkSGJnQndqbnVD?=
 =?utf-8?B?NG15dUxSMkZ3Zy9zUUFXSnY3a0pTcHJTWkxkRnQwQzdDckhHQXF6b0ZtVVhy?=
 =?utf-8?B?eFp4a3M3NEZva2JWaVdEcW1rb1p6dEEyaWZCS1ZWVFVnRlBiVllvUVkyM1cx?=
 =?utf-8?B?NVBiQmQza05FdjIrK253YnR3Wlk2dGgwU2xnMlZIemdEd0JCdE9ncDhzdXY5?=
 =?utf-8?B?d1RMSmZKMDNGRnRqcisvNkl2NlhCZTNPMUtvZGJUank3Y04zM1Q0clJyRGdp?=
 =?utf-8?B?SDBCZGhyaE9TajhEMythaWhzNWNBR1kwQmNqSThSNE51bG8vTGdRck5QVFVV?=
 =?utf-8?B?VUF2YWNvaHRoU2R2TjIrZTB5dEVwY2xpUVBnK0xjajgrV1Rod2hpS0hYczBU?=
 =?utf-8?B?QkovWkRLdlhlWkQvdEEydUxVRE9rKzVLc3FnUTZHSG9pditIcVVWUjUyeDhK?=
 =?utf-8?B?b1RZWnI1dG9qcTdKUXFyU0JyUmRvSGlEckNrRUsvYy80bFdMQkZuT0NacHhV?=
 =?utf-8?B?ZytSTnVLUExyL1laeFUyN2Z3VDEyaDVKTTgzU1FtV1lEdEpLTjBWbDI2SEdv?=
 =?utf-8?B?eWVWRW5MSlluWkl5M1BvWUswUE9GaG41RjlHYmJuT05SODZGbVlxRHEwY3Rz?=
 =?utf-8?B?d1d0QTZQMVA5T05PVjBKMFMvQ01RQU00Z1AxYUhOTU1sUDl1OGRoRXk0RDZW?=
 =?utf-8?B?YzlHK2dxdTBDczZBd0hzL3NjRGE1REdreFZGcnM1NW1yUCtEcURLZUFUeFhV?=
 =?utf-8?B?WkkwZTFMb21FcUFaQU45bXl5a2hCUXkwdXhoOUF6OUZwa1dDVlRHTTNKblEx?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B32446600678644852A47145871DE3C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d20f28-c22f-4904-b6b6-08d9ecefde29
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 23:48:41.6531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyAjK7AappNPoRfUkkA12ZAm7jnhlJYO+aWUJGQk7SOvw/A0FjtJJrzBl/4JbtaC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2509
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: i-AcOYjAVFSpFyxiOAYvnlB0TU8SqV91
X-Proofpoint-ORIG-GUID: i-AcOYjAVFSpFyxiOAYvnlB0TU8SqV91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_11,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 mlxlogscore=879 impostorscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202100123
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTEwIGF0IDE0OjQ0IC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+ID4gKy8qIGRlY2xhcmUgdGhlIGludDY0X3QgdHlwZSB0byBhY3R1YWxseSBiZSAzMi1iaXQg
dG8gZW5zdXJlIHRoZSBza2VsZXRvbg0KPiA+ICsgKiB1c2VzIGFjdHVhbCBzaXplcyBhbmQgZG9l
c24ndCBqdXN0IGNvcHkgdGhlIHR5cGUgbmFtZQ0KPiA+ICsgKi8NCj4gPiArdHlwZWRlZiBfX3Mz
MiBpbnQ2NF90Ow0KPiA+ICtpbnQ2NF90IGludGVzdDY0ID0gLTE7DQo+ID4gK2ludDY0X3Qgb3V0
dGVzdDY0ID0gLTE7DQo+IA0KPiBUaGlzIHdpbGwgYmUgc28gY29uZnVzaW5nLi4uIEJ1dCB3aGVu
IHlvdSBkcm9wIF9fczMyIHNwZWNpYWwgaGFuZGxpbmcNCj4geW91IGNhbiBqdXN0IHVzZSBfX3Mz
MiBkaXJlY3RseSwgcmlnaHQ/DQoNCkFjdHVhbGx5LCBuby4gV2UgbmVlZCB0aGUgdHlwZSB0byBo
YXZlIHRoZSB0ZXh0dWFsIHJlcHJlc2VudGF0aW9uIG9mIGEgNjQtYml0DQp0eXBlIChpbnQ2NF90
KSBidXQgYSBkaWZmZXJlbnQgdW5kZXJseWluZyBzaXplLiBUaGUgdGVzdCBpcyBlbnN1cmluZyB0
aGF0IHRoZQ0Kc2tlbGV0b24gaXMgdXNpbmcgdGhlIHVuZGVybHlpbmcgdHlwZSBhbmQgbm90IHRo
ZSBhcHBhcmVudCB0eXBlLsKgDQoNCllvdSBuZWVkIGEgbGF5ZXIgb2YgdHlwZWRlZnMgdG8gaW50
cm9kdWNlIHRoYXQgY29uZnVzaW9uIGFuZCBpbnRYWF90IGlzIGlkZWFsDQpiZWNhdXNlIGl0J3Mg
bm90IG5vcm1hbGx5IHRyYW5zaXRpdmVseSBhdmFpbGFibGUgaW4gLmJwZi5jIHByb2dyYW1zLg0K
DQpgdHlwZWRlZiBzaWduZWQgY2hhciBpbnQ2NF90O2Agd291bGQgYWxzbyB3b3JrLCBpZiB5b3Ug
cHJlZmVyIHRoYXQuDQo=
