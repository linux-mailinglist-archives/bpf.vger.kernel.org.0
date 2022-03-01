Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFF24C93A8
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 19:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbiCAS5m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 13:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbiCAS5l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 13:57:41 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6788661A0E
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 10:56:58 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 221GjK7d029912
        for <bpf@vger.kernel.org>; Tue, 1 Mar 2022 10:56:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ElczoQ40P3AZuoKlEgE7yMsRv2bt7r5vgo+c6n+4DMM=;
 b=Ii94hRQdcEvo+pMkiRIRI9uWfkR4R7OUMH1H9yw8332mSrn8f0TKAfwZ6U8WG4aaR4WU
 XeJHxENRSEtke7/FwvuR3madxalwIdAExP6HtGXicIhUZtKVJVXtvSh2CEFPWRqury+A
 X5jdGA2rv7j7CQPXVn/5VarRwg7v+tqBDys= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ehjnvu76g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Mar 2022 10:56:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6KfQUlmEP3JxfCO8/3EbbZ1YAb3rPxSKgQy53UibOpcgqAhGAQYrf3dZteEdv2djdhwIl5l5dOiajZduv7ah/oRgVDDIYFjZG21XQe+1wUccDd4PKjOhyDxHnyn6YqiqSR2VKjyft106lJxHV1z8YNgNg9vNazoumNQG+Z9SVbXxWlKnY0zyz7enhoun9r7Sv2O9L8yb7ULZSiVSIZZ8mgSQyKVVMO+nHmHTqqkh1grLfJsJjcF6763+bet09niMXqfuvr11FMNBLhpxi5P7ohCQrSw0ip/1wJ5NofffzjQlBKAQX8jwjNklRywM0o8keFXBfXB6OsjRNdnUdjnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElczoQ40P3AZuoKlEgE7yMsRv2bt7r5vgo+c6n+4DMM=;
 b=HdLjVgAFbMblx54w0QCGvDDfLWyOIFnMlJDNN85n0maubQSW2xOSQ1bRRGrx/HndUHmLg0caya5Kai4JFFOCS6XVhlpwAKpn7oidMw5c4G4gYILug/R1rCs7QeUa+P5L/aBbFG4x5Le3pJnBryJXwExCT/WJgo6s/SowkMYTvBc2SOXeXU91gONAYbsSMJ/Pf3IXfn5+C0SGiobk0J22CBq1s5cY0uv0mQC4lGCnvoNyvUVzAU4fek4VmlX8Yi8U+aocKPgdxfYrhTf9YIEVtNt0ucBNPTSz7R8avhTlyTwSznsc8nPqGiBR4z1J2TV0dIA9i5Jr6V1rlij9qZsX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by MW3PR15MB3897.namprd15.prod.outlook.com (2603:10b6:303:49::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 18:56:54 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::94b7:4b41:35e4:4def]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::94b7:4b41:35e4:4def%4]) with mapi id 15.20.5038.014; Tue, 1 Mar 2022
 18:56:54 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v4 bpf-next] Small BPF verifier log improvements
Thread-Topic: [PATCH v4 bpf-next] Small BPF verifier log improvements
Thread-Index: AQHYKRccDPJzhkwSQU68rDIN3MLhMayqj8mAgABaRAA=
Date:   Tue, 1 Mar 2022 18:56:54 +0000
Message-ID: <DBC16090-E170-4725-A872-36D98568E9DF@fb.com>
References: <20220224003729.2949667-1-mykolal@fb.com>
 <feebf924-426a-7128-993d-10a642088ccd@iogearbox.net>
In-Reply-To: <feebf924-426a-7128-993d-10a642088ccd@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c0ec32d-41a0-4664-a0ee-08d9fbb54103
x-ms-traffictypediagnostic: MW3PR15MB3897:EE_
x-microsoft-antispam-prvs: <MW3PR15MB38974F07A07FB4C8DD45CF99C0029@MW3PR15MB3897.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1HjDR6Y9XEyKvqpJg5Ucf8Cy4Q8yyfDttYtNwFstrbjw+yivjMn9k3CUOFtzTupHtOZImCsYcpbxtcYA32pYTHRw2M6OwqyAF58pJckEZ7bH+81mf6EKPiAzdGRCOCpTK9M4/2/0oEGvsVUoQ0o8+av5NqrP4jLckCqySEaRzV4Th+MPTREXCvYfhDE3/2JtF8qRt2fxkXidKgBf9Jil7Cxo8SFZ8kqpanwsjqmOlaGTUe58heJ6ENQUGwNum8nJxycftisHvn/NRhIjuk8ZrMG5q4O3lKaBKj8+FHzKj8KWsBiHy0d/2B1Q9ZnfQClvPCLSKIEpzcm3oDIgEyuzCco9/CDad3CcMQO9y2u4enlfgmjE6ulPezgi2bveZJw9Cnx+UECoGQpClhTjjbKtTCRE+FupXmADpg/Ce95paIN7kH02MNYlCfhUIdLDfwFXKcP79WQz6Ia2h6RU3wZCtNQ+aW9o81C44zvQpHTv3hDMrf4ufMYUyyFU6K9eVgrMIjYhf4xOCVSjuBjTjl++WIJzg1pZz+BFkIiM/+2cxaNk3uNZOUffeQC+2Cnrr51DgrvCNKGJI8iT62w+Jor9lrRWin5l8bLrvkYkCoQmtnU3NSFO64C93Wf9yYhwwe7HsEm/hKybKC/DcGM7VsoJjLtcXDO2WmCjOXWBgNh5hrBrBenZRruhog21NfSXTSJA+iDR/ccierceUITIcF62HpXOVMtRL9ztzG604Wpm8OxSfAAnLNnJkxt+NwSTWZdD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(83380400001)(508600001)(53546011)(6486002)(71200400001)(33656002)(54906003)(316002)(6506007)(6512007)(36756003)(122000001)(2616005)(38070700005)(38100700002)(2906002)(4326008)(76116006)(8676002)(186003)(86362001)(8936002)(5660300002)(66476007)(66946007)(66446008)(64756008)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0RPRnhaTzVjbno5ZkZ0T1doTjRZMW5WOWNWZWNVYnFpNUNiUkR6Vk1xbHFC?=
 =?utf-8?B?SGE2TnY1d2JQR0tmMkFueFcwT2kzVjViZ3h6VkRIVUV1RVVldHBlcDgzeVhm?=
 =?utf-8?B?QTZ2NTUyK1NUM28wMEU5WituODV2cjN2RU13VW5uV1BZY1k5ZmErSHBGYnli?=
 =?utf-8?B?eWl6VzZscDJGZk1UWFNHaUdySXNIRk50QzB1VnpwS2syU29ENHIrN3ZwVm5C?=
 =?utf-8?B?K1RSTlRabmRSZXl6UDZ2emFyWmVXRnU0R1ZMaDBDNHVNT2ErUU5OL1k1Z280?=
 =?utf-8?B?QW9QTmtsQWVLVjk5NG52citJZXlGTGNWYkMwVEZHL2xaQ3Jrd2grakwrdUpM?=
 =?utf-8?B?NW5CWFU2MXhzR1RRS1YyU3kwcVcxT2lEZGFQUDBDb0czTkxZdC9hWFJvZG40?=
 =?utf-8?B?bkJpKzgyVFE1cmJISERvQWpFL2lXZEtHQm9BYW80Rk95WDY0czZWVDIzMTlX?=
 =?utf-8?B?S3ZWOWxPc0FCMUlEMUVLL0RjNnJRTWs3WDY1cFlsemRZWWdFOXIzN0lNTXlJ?=
 =?utf-8?B?VFFOY2tPZUJVMFhOTWUzYXNwQmRTdFhnc3ovMncwa3hBY094TTFrRm1SZkhm?=
 =?utf-8?B?cExFQXBJbXA3TWhRdHpGbUhWUC95V1BleStGVFEyM1hCQ3VOdExOKzM1MDJW?=
 =?utf-8?B?VVVaTGJNcWJ0cnVIUkF0bzdNL1huLys2THdyQzk2MnFVNlNNUStIcitIZ2Qr?=
 =?utf-8?B?dE85STJqeHBObVc3YUFqbW1VSnpWWVVTYjc3VTlDaTNTcHJhNnFSalZ1SkU5?=
 =?utf-8?B?bFE4RVFJcEYxR3JSRk92VndySnhTSEIwcnEwNEtYMmhMUmo5b0lkSVFEYTBs?=
 =?utf-8?B?TWxibzRlVTNpcnBHZnF3QnlDRlYzc2Y1ODlvZGFvTG56V2RyZW1iUG9mNnd4?=
 =?utf-8?B?clJEbzU2K0RLM01WaFRpdkkxa09zK2ZDTG96THdYakdobGp1NU9xMVh1NHJO?=
 =?utf-8?B?bmJDUVFzQWd5R2dDS1JRMkVuSUlzcldYTHR1QmxvdmxkMUw0ekNyaWVrYVpr?=
 =?utf-8?B?eWNYL1BYbVVpOGtiYWd1SHFvUWFGZDd6MHNqVmJNUEJMZzVVaDhzbjNNWjNa?=
 =?utf-8?B?aU1Qa0JjWFNnWWNHQ2doWGRUM01uc1A3d1NTYkhNY3pqZXVxVG9IRmM5M1NY?=
 =?utf-8?B?YlZCakFmaDZoWHZVYUJLUmpCSHpULytrbzJlVU41WmkwMElLWWRjamxNTWRM?=
 =?utf-8?B?YjdxOWpITjAreGdSSDBwc0svZTZ1TG1zMjU5dTFteHpEMHJRWCs3MWJlWHFT?=
 =?utf-8?B?bW96eU1oaGRidnE5N3ZxcXkyeW9CNFhndjBYTlZhMWJqai9GVkQ5RU1Ka092?=
 =?utf-8?B?L1BNcXdQSVhkOUxidXd6a2xuNU5hZWRmMVBtcC9IdlR5YzlvMEI1VHJMWlJl?=
 =?utf-8?B?UFBmejBQMmwrSC9URTdMRHZvOTJ1QlJKUmZSSUtINkUzZjhObUc2Y2pZc2VU?=
 =?utf-8?B?VG9pTk9kM3VtTzBrUnlGbnV0THdGVzBPbTRtWHkzNHRxM3Bxb2xZQzB6R04v?=
 =?utf-8?B?NkNUaStib0txTWQ2UmFRQ0F4VFZ6SUU3RFdraThRN29YbnhsSmc0dCsxZ2ND?=
 =?utf-8?B?bldzODN2ZTZ4eWE4RE9OV1ltQkpDN2ZiQUZwTDJFeXdxN2xoSXF3NTVDT2g3?=
 =?utf-8?B?a0p3YkplNFBwaldvT0NQSXptR3ladm01eFlaa25iNXhMd0ZObm9Wbm00eTVC?=
 =?utf-8?B?Y3NCNi81UkI4K3Z1MGw2UWxIQmdTY2syM3BXbzJFekVjZjh3azhwUWZraWtk?=
 =?utf-8?B?RVZRaXhtdEtraGgvdFNVTHhZMUtVckRNTy80Zk1hSFltaEY0ZllnVFpuVmFJ?=
 =?utf-8?B?bFhXZVNYSEtJbDdlWmI4cHcwTU05dU5MWGpsSTNva1dvcmdEQ2p5U2FCQ011?=
 =?utf-8?B?WUlwdHU0djV0cEZ5Z3J3VERTNlFkSFIxbTBpTHdMcEFuaUllRGRiczNxQmsr?=
 =?utf-8?B?dEUwR1dmd01qSDlqVWdkbGlOQzc2MllVS0NhZk13cmFTTFk4a0JyK0RPU3hG?=
 =?utf-8?B?S2prZlluYldFK2czRDBWR25TNExGZi8xUi96QlIyS05YNmdKUkNTMXRYaHpt?=
 =?utf-8?B?Z3pXWExkQ2JWODVvYWhWV3V2QlI3aEd2VE9ra3MyK0pvbU9zTEQyd0ZGWG43?=
 =?utf-8?B?bzQzeWNmWGtOQ29WNUxyaStkZXJFS3djbnY0d3huSHEwZkVRYTFCajhpblBE?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF72C749E085974C8AF7837836C8F559@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0ec32d-41a0-4664-a0ee-08d9fbb54103
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 18:56:54.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TOJIE5jR62XdHjLRiyDzl4a7I9Q3yt2ypZhaM3m0p///g+uWCGX4izq1+GYgGf3R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3897
X-Proofpoint-GUID: zE5Ytfp90Xy4Gtvt277OlaJQnoAHYHHT
X-Proofpoint-ORIG-GUID: zE5Ytfp90Xy4Gtvt277OlaJQnoAHYHHT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2203010094
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQpIaSBEYW5pZWwsDQoNCj4gT24gTWFyIDEsIDIwMjIsIGF0IDU6MzMgQU0sIERhbmllbCBCb3Jr
bWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+IHdyb3RlOg0KPiANCj4gSGkgTXlrb2xhLA0KPiAN
Cj4gT24gMi8yNC8yMiAxOjM3IEFNLCBNeWtvbGEgTHlzZW5rbyB3cm90ZToNCj4+IEluIHBhcnRp
Y3VsYXI6DQo+PiAxKSByZW1vdmUgb3V0cHV0IG9mIGludiBmb3Igc2NhbGFycyBpbiBwcmludF92
ZXJpZmllcl9zdGF0ZQ0KPj4gMikgcmVwbGFjZSBpbnYgd2l0aCBzY2FsYXIgaW4gdmVyaWZpZXIg
ZXJyb3IgbWVzc2FnZXMNCj4+IDMpIHJlbW92ZSBfdmFsdWUgc3VmZml4ZXMgZm9yIHVtaW4vdW1h
eC9zMzJfbWluL2V0YyAoZXhjZXB0IG1hcF92YWx1ZSkNCj4+IDQpIHJlbW92ZSBvdXRwdXQgb2Yg
aWQ9MA0KPj4gNSkgcmVtb3ZlIG91dHB1dCBvZiByZWZfb2JqX2lkPTANCj4+IFNpZ25lZC1vZmYt
Ynk6IE15a29sYSBMeXNlbmtvIDxteWtvbGFsQGZiLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgaGVs
cGluZyB0byBpbXByb3ZlIHRoZSB2ZXJpZmllciBvdXRwdXQuIFNtYWxsIGNvbW1lbnQgYmVsb3c6
DQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyENCg0KPiANCj4gWy4uLl0NCj4+IGRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9hbGlnbi5jIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvYWxpZ24uYw0KPj4gaW5kZXggMGVlMjll
MTFlYWVlLi4yMTBkYzZiNGExNjkgMTAwNjQ0DQo+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9icGYvcHJvZ190ZXN0cy9hbGlnbi5jDQo+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9icGYvcHJvZ190ZXN0cy9hbGlnbi5jDQo+PiBAQCAtMzksMTMgKzM5LDEzIEBAIHN0YXRp
YyBzdHJ1Y3QgYnBmX2FsaWduX3Rlc3QgdGVzdHNbXSA9IHsNCj4+ICAJCX0sDQo+PiAgCQkucHJv
Z190eXBlID0gQlBGX1BST0dfVFlQRV9TQ0hFRF9DTFMsDQo+PiAgCQkubWF0Y2hlcyA9IHsNCj4+
IC0JCQl7MCwgIlIxPWN0eChpZD0wLG9mZj0wLGltbT0wKSJ9LA0KPj4gKwkJCXswLCAiUjE9Y3R4
KG9mZj0wLGltbT0wKSJ9LA0KPj4gIAkJCXswLCAiUjEwPWZwMCJ9LA0KPj4gLQkJCXswLCAiUjNf
dz1pbnYyIn0sDQo+PiAtCQkJezEsICJSM193PWludjQifSwNCj4+IC0JCQl7MiwgIlIzX3c9aW52
OCJ9LA0KPj4gLQkJCXszLCAiUjNfdz1pbnYxNiJ9LA0KPj4gLQkJCXs0LCAiUjNfdz1pbnYzMiJ9
LA0KPj4gKwkJCXswLCAiUjNfdz0yIn0sDQo+PiArCQkJezEsICJSM193PTQifSwNCj4+ICsJCQl7
MiwgIlIzX3c9OCJ9LA0KPj4gKwkJCXszLCAiUjNfdz0xNiJ9LA0KPj4gKwkJCXs0LCAiUjNfdz0z
MiJ9LA0KPiANCj4gQWNrLCBkZWZpbml0ZWx5IGJldHRlciBjb21wYXJlZCB0byB0aGUgc3RhdGUg
dG9kYXkuIDopDQo+IA0KPiBbLi4uXQ0KPj4gQEAgLTE2MSwxOSArMTYxLDE5IEBAIHN0YXRpYyBz
dHJ1Y3QgYnBmX2FsaWduX3Rlc3QgdGVzdHNbXSA9IHsNCj4+ICAJCX0sDQo+PiAgCQkucHJvZ190
eXBlID0gQlBGX1BST0dfVFlQRV9TQ0hFRF9DTFMsDQo+PiAgCQkubWF0Y2hlcyA9IHsNCj4+IC0J
CQl7NiwgIlIwX3c9cGt0KGlkPTAsb2ZmPTgscj04LGltbT0wKSJ9LA0KPj4gLQkJCXs2LCAiUjNf
dz1pbnYoaWQ9MCx1bWF4X3ZhbHVlPTI1NSx2YXJfb2ZmPSgweDA7IDB4ZmYpKSJ9LA0KPj4gLQkJ
CXs3LCAiUjNfdz1pbnYoaWQ9MCx1bWF4X3ZhbHVlPTUxMCx2YXJfb2ZmPSgweDA7IDB4MWZlKSki
fSwNCj4+IC0JCQl7OCwgIlIzX3c9aW52KGlkPTAsdW1heF92YWx1ZT0xMDIwLHZhcl9vZmY9KDB4
MDsgMHgzZmMpKSJ9LA0KPj4gLQkJCXs5LCAiUjNfdz1pbnYoaWQ9MCx1bWF4X3ZhbHVlPTIwNDAs
dmFyX29mZj0oMHgwOyAweDdmOCkpIn0sDQo+PiAtCQkJezEwLCAiUjNfdz1pbnYoaWQ9MCx1bWF4
X3ZhbHVlPTQwODAsdmFyX29mZj0oMHgwOyAweGZmMCkpIn0sDQo+PiAtCQkJezEyLCAiUjNfdz1w
a3RfZW5kKGlkPTAsb2ZmPTAsaW1tPTApIn0sDQo+PiAtCQkJezE3LCAiUjRfdz1pbnYoaWQ9MCx1
bWF4X3ZhbHVlPTI1NSx2YXJfb2ZmPSgweDA7IDB4ZmYpKSJ9LA0KPj4gLQkJCXsxOCwgIlI0X3c9
aW52KGlkPTAsdW1heF92YWx1ZT04MTYwLHZhcl9vZmY9KDB4MDsgMHgxZmUwKSkifSwNCj4+IC0J
CQl7MTksICJSNF93PWludihpZD0wLHVtYXhfdmFsdWU9NDA4MCx2YXJfb2ZmPSgweDA7IDB4ZmYw
KSkifSwNCj4+IC0JCQl7MjAsICJSNF93PWludihpZD0wLHVtYXhfdmFsdWU9MjA0MCx2YXJfb2Zm
PSgweDA7IDB4N2Y4KSkifSwNCj4+IC0JCQl7MjEsICJSNF93PWludihpZD0wLHVtYXhfdmFsdWU9
MTAyMCx2YXJfb2ZmPSgweDA7IDB4M2ZjKSkifSwNCj4+IC0JCQl7MjIsICJSNF93PWludihpZD0w
LHVtYXhfdmFsdWU9NTEwLHZhcl9vZmY9KDB4MDsgMHgxZmUpKSJ9LA0KPj4gKwkJCXs2LCAiUjBf
dz1wa3Qob2ZmPTgscj04LGltbT0wKSJ9LA0KPj4gKwkJCXs2LCAiUjNfdz0odW1heD0yNTUsdmFy
X29mZj0oMHgwOyAweGZmKSkifSwNCj4+ICsJCQl7NywgIlIzX3c9KHVtYXg9NTEwLHZhcl9vZmY9
KDB4MDsgMHgxZmUpKSJ9LA0KPj4gKwkJCXs4LCAiUjNfdz0odW1heD0xMDIwLHZhcl9vZmY9KDB4
MDsgMHgzZmMpKSJ9LA0KPj4gKwkJCXs5LCAiUjNfdz0odW1heD0yMDQwLHZhcl9vZmY9KDB4MDsg
MHg3ZjgpKSJ9LA0KPj4gKwkJCXsxMCwgIlIzX3c9KHVtYXg9NDA4MCx2YXJfb2ZmPSgweDA7IDB4
ZmYwKSkifSwNCj4+ICsJCQl7MTIsICJSM193PXBrdF9lbmQob2ZmPTAsaW1tPTApIn0sDQo+PiAr
CQkJezE3LCAiUjRfdz0odW1heD0yNTUsdmFyX29mZj0oMHgwOyAweGZmKSkifSwNCj4+ICsJCQl7
MTgsICJSNF93PSh1bWF4PTgxNjAsdmFyX29mZj0oMHgwOyAweDFmZTApKSJ9LA0KPj4gKwkJCXsx
OSwgIlI0X3c9KHVtYXg9NDA4MCx2YXJfb2ZmPSgweDA7IDB4ZmYwKSkifSwNCj4+ICsJCQl7MjAs
ICJSNF93PSh1bWF4PTIwNDAsdmFyX29mZj0oMHgwOyAweDdmOCkpIn0sDQo+PiArCQkJezIxLCAi
UjRfdz0odW1heD0xMDIwLHZhcl9vZmY9KDB4MDsgMHgzZmMpKSJ9LA0KPj4gKwkJCXsyMiwgIlI0
X3c9KHVtYXg9NTEwLHZhcl9vZmY9KDB4MDsgMHgxZmUpKSJ9LA0KPj4gIAkJfSwNCj4+ICAJfSwN
Cj4+ICAJew0KPiANCj4gSG93ZXZlciwgbm90IHByaW50aW5nIGFueSB0eXBlIGluZm8gaGVyZSBp
cyBpbWhvIG1vcmUgY29uZnVzaW5nLiBGb3IgZGVidWdnaW5nIC8NCj4gdHJvdWJsZXNob290aW5n
IGtub3dpbmcgdGhhdCB0aGUgcmVnaXN0ZXIgdHlwZSBpcyBpbnYgb3Igc2NhbGFyIHdvdWxkIGJl
IGhlbHBmdWwuDQo+IEZ3aXcsIHNjYWxhciBpcyBwcm9iYWJseSBhIGJldHRlciBmaXQsIGFsdGhv
dWdoIGxvbmdlci4uDQoNClNvLCBqdXN0IHRvIGNvbmZpcm0uIFlvdSBhcmUgcHJvcG9zaW5nIHRv
IGxlYXZlIGNhc2VzIGxpa2UgIlIzX3c9OOKAnSBhcyBpcywgYnV0IGNoYW5nZSBjYXNlcyBsaWtl
ICJSM193PSh1bWF4PTI1NSx2YXJfb2ZmPSgweDA7IDB4ZmYpKeKAnSB0byDigJxSM193PXNjYWxh
cih1bWF4PTI1NSx2YXJfb2ZmPSgweDA7IDB4ZmYpKeKAnSwgY29ycmVjdD8NCg0KPiANCj4gVGhh
bmtzLA0KPiBEYW5pZWwNCg0KUmVnYXJkcywNCk15a29sYQ0KDQo=
