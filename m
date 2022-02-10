Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369B24B19F4
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 00:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbiBJX7P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 18:59:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344855AbiBJX7P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 18:59:15 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39C7B47
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:59:15 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ANrgq0007907
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:59:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=eukGbhcuGyVXX4XiuJ/x6PdlAtpdTlRfpUC4pDov4EY=;
 b=nG2Rsrys4QBuGb9D3jDM8pgEr3nvbuHjzYd4DDpcuYTlSUyzOB+FSXRr14fBkf83w9L+
 xK7QtGzkunIamdS7LWmcmuXzByOhXmf+q6cn8Vbpdt1eqARqzjSqyTtYO2RBWI/yUFir
 z12HZj2mhe4L2ZurxdrhgVj9tqmUQkP+YPU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e5853a762-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:59:15 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 15:59:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOKqPWBTaVhPIP8g9jMhXG47gKvi9Qiz6oshOFVHuCiegsc4XkRzTIp8OCShGFriI10A+xjoL5NkJmWwmNYluJ/w2n+ix0rvTYD0mttgLCc2T0tg/r3EUaGXL6liM6CbUCzNnXsDBFgW/1e4m4pQLWywguFEfOH9BLndKceGbDvFG/hEglAJe8yPBtagCcMcB/jPpccluPnBCIsDmVXcERGgMfmYHRMcU3rOFZZFCfPlSrMuLrRg2sjgFHMn1LROuItNyXjoecrcaIwfOO9q7ho0wn5JoUnkrA317AerWqgDGUzF46WICini8dD6LkvV4ePUqBTERWB94ASj+zCbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eukGbhcuGyVXX4XiuJ/x6PdlAtpdTlRfpUC4pDov4EY=;
 b=Dzk+C8jEDIUGbH4lEyIHd0invsT77FYButd7rlsez7NXa6gL+bmXjfh4faIIAXDqSuprJynelXJLSUIfeGh1NRUNrVRcKjdYX2sXcXIcumyJuAik3/Eur5ltpXDxsIu4BwSK3jHbMenn11A9/ijFyAeWC3B8/o+QEqiuvmip9O7SdSIkJl2b6/cpeSMngu3vjBHfo4PSiRoT+cGHIDVl6JUSQxm6braBzvbH9HVaXZgavLpK7fPwjqYADBHGdPSKf9B+azD1YmyUSDCBJp6CwOnngIJ86Gzy4efl56EldKpdXM2o/oGUAu0qLAuX6AMaFU0H4amx0KCpeLfCZrbdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by CO6PR15MB4212.namprd15.prod.outlook.com (2603:10b6:5:353::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 10 Feb
 2022 23:59:12 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7%5]) with mapi id 15.20.4975.012; Thu, 10 Feb 2022
 23:59:12 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     Yonghong Song <yhs@fb.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 0/3] Avoid typedef size mismatches in
 skeletons
Thread-Topic: [PATCH bpf-next v1 0/3] Avoid typedef size mismatches in
 skeletons
Thread-Index: AQHYHhZOC9SakN/n9kaJ9hboeaEJ6qyNZT2AgAAGcoCAAAtPgA==
Date:   Thu, 10 Feb 2022 23:59:12 +0000
Message-ID: <b475429b1521d83c2b538f83b9013c9ee9b13d10.camel@fb.com>
References: <cover.1644453291.git.delyank@fb.com>
         <78216409-5892-6410-a82c-0ebf5fdb1504@fb.com>
         <CAADnVQKk-uOEkEiPuBu7W_oYx=gTGpruK6Kc0ShTcFYEAbCczA@mail.gmail.com>
In-Reply-To: <CAADnVQKk-uOEkEiPuBu7W_oYx=gTGpruK6Kc0ShTcFYEAbCczA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a945118-9615-45de-fa05-08d9ecf15613
x-ms-traffictypediagnostic: CO6PR15MB4212:EE_
x-microsoft-antispam-prvs: <CO6PR15MB421240E361A642B26352A3FAC12F9@CO6PR15MB4212.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +eClz8dQA8C7Aoj46JhqkLj1c3qlCPHA0hxeGgUc3mvkofyQjVAeJgdvec8F3Sr45QjdsgpAd0k76t28HTmo1mz9+79MNhvWjT9Jsek7cYVTp/qCf9GaGhV2NYSfO8PsBSIV7QyROXyFAS+odiackNGsfgVFHS9pbuKATxGerLsyZL0boSWjAhPTEbFvIG1zDqeyvGfEso1LELdThFwKdyXqtXnJPQdH80cn7qKFIV6D95mAJcIBKX2ngMtMHQ13JUIA1PvFPj+K6CPinLf5/n6upAz35SqpkBv1KgeA8cZqdg8oENVenwhmMCnTcnRQvX0BcadsmeDd5MuWUcPGdKysCrqazlGIMQpMYAKn/5XfuXAAVIWvm5BNb02dfsypaoGeUI92Zm0Ld9meqp6/FkPqhhi1ECRYEJOuGVJzQQtbxFA37LZmuZWELEPfK0JDR4IW8Qux2lIX0gR+x7Hy9ofL3NwvOquWL4SUbXEF3kTJMC0QGqqqbXfdroMl5cgm3oytHHpxdhI31GjMjVE2zLpaEhrTjl1LgFSyI3D4yCl/qwiMu/qz1xu6I0qG8ws+XtUrMSyWzKCSLe9cqj1+3CWuYNPBZczB+v7nNwHLPINZZWIwfMqIiCI8ffS5dR5aNpQTcXCAsjz2J/PFCQsHRk6boU3Hp0WEoaQvHZztUXzRp7L4vokUieX1/5AWqZEmNsspyUjosdv5Uh9FvFXjjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(66556008)(66476007)(66446008)(64756008)(4326008)(66946007)(6512007)(76116006)(508600001)(8676002)(186003)(8936002)(2616005)(71200400001)(2906002)(86362001)(6506007)(38070700005)(38100700002)(122000001)(6486002)(316002)(36756003)(5660300002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZER3TnVxaFhVRDJtd0JFVHMyTFVrVG5vK2F0YmhqaVhDUUN1ancrOWtnWGtE?=
 =?utf-8?B?c3ZxZzBnS1VLY1RYZ1dFbm1JNHVMaTArekxrYTB2eWZhOFI5RWEvZGVJR3N0?=
 =?utf-8?B?dlduTTFmcWVSazJmQ1E5U0M4L3FSUVRhdjh1eW5rc09KRU1VRE1qS25wTkRF?=
 =?utf-8?B?UHlHTUJPNkNPQlNLQkV5VUxyR3pwYUdwMUZldUVHQnBzQWNzU1BlUlE4Vy9n?=
 =?utf-8?B?a2pudnBNMGpvY3JpSWM2bXptczd2VHlvbjJ1cUs4c0I0S2IvdjlEU085c3R1?=
 =?utf-8?B?UXVyZmVZWlUvdW90R01VYnQ3OStwYVUyM2FIWWN2RXU5elZoV0sra1F0M3JG?=
 =?utf-8?B?c3BHRWlrcnR3RnllTWlyS2JjQk5ISENtR2dIY2tSUHRLSk9xVGRkamxqVHB2?=
 =?utf-8?B?THdKaWQvT2YyeElkdm5ZeGM3U09hUmV0ZHVoNXB4Q3o3WWJUSGtCWitSamp1?=
 =?utf-8?B?eG5EdWdNNzhGL2xNNE9yS3RqQmNvbVZHeXJkNXRRUkNjVW9RUmhSSWJtYkVJ?=
 =?utf-8?B?R1kvdHRPT0JLb0ZKNnVuKytFY1pTVDJNUjlPenRJRWxtU3U2UStvbm00aWlw?=
 =?utf-8?B?S0tHbzdTUnVYbmRTR0ZLTGZZZnlRR1cxMlBQUWFkSUNxbTJNZ3RXaHVDVFBv?=
 =?utf-8?B?N0doUXhSbjdJMncvSGxqcTBtb0tMRy9XcTZUelk5a0pjTDM2YlZicU1aU1dm?=
 =?utf-8?B?YVFBcUhHemswMyt1M1RJRXNYelMrL1k1SUZzYkNJaFVtWkFkVkIwajI3bFJP?=
 =?utf-8?B?am9BNHNzazJLMWdHSHdQdEV6YWN4NE8yem9lSGFrV2w2ck9rdklrazAwcEg0?=
 =?utf-8?B?bzhVYlVWWmd0VEJ2RXI2dEcwcjUxQ3I4M1pLRFJEWWhHT0FZUURveGRBV3R4?=
 =?utf-8?B?OFhaMVhIZmE4TVFMaTVWaUxmWkExVUwycllJSnkydnExaUxZN3VHQVdLeGlD?=
 =?utf-8?B?WElKUGNSVmtNSldNWDRtdnNQa2xkS0xkMDZJcUpPaENiZkxtalh1dFpUWFkv?=
 =?utf-8?B?cmlMdUI5Wktvd1d5ZW5YUG1za0t0aVJRZHlKcFZHTDBacGd6Q245N3h5R3JX?=
 =?utf-8?B?M05YTHNwYzYvaEJETGJjRXlVdGNMK2EreHR0ai94TzE4dkJGZmVIcTdFaEFZ?=
 =?utf-8?B?L2ZyNUpHSTlDZytRVGdoeHU1TXJEU3JKMUgwd1VPd2dpaVp0amVUM2o0SjNS?=
 =?utf-8?B?S0tYSFBOUUdJdy8zR1hFVWJXRGJzdWZBV3dwOTczR3AxN2RBVnZBem8wdnBM?=
 =?utf-8?B?aE14VyttMUVRNUtKMDFGcjA2cFA2NGFHNnNhZHdaL3dFSWlIV0QyRGpEM0Nq?=
 =?utf-8?B?U2gwbzJkOFhobHh2dHBqVlZjWFVXbmk1amhJT2FmWDFFNmkvNEZJVFArbTRx?=
 =?utf-8?B?QUdpZGhhb29hay9qdEMzVE1RQjFJdjJZbHVjRzAra3FEZ1VRV1VMVm8zU2Nx?=
 =?utf-8?B?MTAvNlc1RGR0dlJGeHMrdVdiUVpRN3htRGlQTnpFTUpzRUxTSHZ0eXZ2NjUw?=
 =?utf-8?B?Rlkra1RJQVU4VHhzSy96dVVUekxGTUlKVDVaTWRJaEZaaWU4V2k3ZC9vZGlu?=
 =?utf-8?B?Ym5ub1BEVGF0SS91MW9USXVVaGlGRDd1aUVwRXoydStHQktYRTFDMTFObUM1?=
 =?utf-8?B?TGtSTysvZnNtbnhBTXlzYkhjR2p4dkVscjRvU2RjaXZndVNKVFo3UmJ1ZTFy?=
 =?utf-8?B?VnU3SjcxeXJOZmttOXBHMnVHdnFUd3hsYVZaVjNQQmhsTk1IZ2N5VGQrSEk5?=
 =?utf-8?B?aVNlR0dXcFZydlRwV1EwYVV1aDBGUTBJM0duOEppcWt5aTBHY20rRVFFK29l?=
 =?utf-8?B?U0RSb3I3MUtSa2JSOEpxemZvYlBINVpTZldEOUMwTUVndmhJcFMvN1cvem1I?=
 =?utf-8?B?cmQwSlVrQ0FyREtjRDRuNXZ1eUkwZy9qbkh5aXJ5RllmdkdWdGdlNkdMQURG?=
 =?utf-8?B?Z3JIN2FtcDdNRGc1bVdacGp1WWI5WEpoNE5hWFB5aFJQQmpWWU1DcFNHNEow?=
 =?utf-8?B?U3VYNm92MW1yNVk5LzhvYmU1SUh5ZDZPeWkvYjlJVWwvYjRweGZSdmNTYmlT?=
 =?utf-8?B?Q3dYMWhnTkk3bzVlNUlCdWRpWDVRTW9uMVYxTndYeHJ2TWFpNXdmcmo4N1lz?=
 =?utf-8?B?VU5lNVI1UEZOalNGKzB0c1JkSWlDbHRnc3lkVi9CMllGc0E4b0tudi91ZDJs?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3CECFC2BADF9142AFAB8CE166FD474D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a945118-9615-45de-fa05-08d9ecf15613
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 23:59:12.4590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ueANgm9VjAuDZzssvAOmVf6Vz583Fobp43jyDxlrwQKCsUor7ZqHRuPjrUQum1kp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4212
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: v_N-gga9Z1Np4e8oE0DquW8wMkVpO_zn
X-Proofpoint-ORIG-GUID: v_N-gga9Z1Np4e8oE0DquW8wMkVpO_zn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_11,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 mlxlogscore=565 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100123
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

T24gVGh1LCAyMDIyLTAyLTEwIGF0IDE1OjE0IC0wODAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IFNvIGFkZGluZw0KPiBfU3RhdGljX2Fzc2VydChzaXplb2YodHlwZV9pbl9za2VsKSA9
PSBjb25zdF9zaXplX2Zyb21fa2VybmVsKTsNCj4gdG8gc2tlbC5oIHdvdWxkIGZvcmNlIHVzZXJz
IHRvIHBpY2sgdHlwZXMgdGhhdCBhcmUgdGhlIHNhbWUNCj4gYm90aCBpbiBicGYgcHJvZyBhbmQg
aW4gY29ycmVzcG9uZGluZyB1c2VyIHNwYWNlIHBhcnQuDQoNCkknbSBub3Qgc3VyZSB1c2VycyBo
YXZlIHRoaXMgbXVjaCBjb250cm9sIG92ZXIgdGhlIGRlZmluaXRpb24gb2YgdGhlIHR5cGVzIGlu
DQp0aGVpciBwcm9ncmFtIHRob3VnaC4gSWYgYSBrZXJuZWwgYW5kIHVhcGkgdHlwZWRlZiBkaWZm
ZXIgaW4gc2l6ZSwgdGhpcyBhcHByb2FjaA0Kd291bGQgZm9yY2UgdGhlIHVzZXIgdG8gdXNlIGtl
cm5lbCB0eXBlcyBmb3IgdGhlIGVudGlyZSBwcm9ncmFtLg0KDQpJZiwgZm9yIGV4YW1wbGUsIHBp
ZF90IGlzIGEgZGlmZmVyZW50IHNpemUgaW4gZ2xpYmMgYW5kIHRoZSBrZXJuZWwsIGl0IHdvdWxk
DQpmb3JjZSB5b3Ugb3V0IG9mIHVzaW5nIGFueSBnbGliYyBmdW5jdGlvbnMgdGFraW5nIHBpZF90
IChhbmQgcG90ZW50aWFsbHkgYWxsIG9mDQpnbGliYyBkZXBlbmRpbmcgb24gaG93IGVudGFuZ2xl
ZCB0aGUgaGVhZGVycyBhcmUpLg0KDQpCeSBub3JtYWxpemluZyB0byBzdGRpbnQgdHlwZXMsIHdl
J3JlIHNheWluZyB0aGF0IHRoZSBjb250cmFjdCByZXByZXNlbnRlZCBieQ0KdGhlIHNrZWwgZG9l
cyBub3Qgb3BlcmF0ZSB3aXRoIGVpdGhlciB1YXBpIG9yIGtlcm5lbCB0eXBlcyBhbmQgaXQncyB1
cCB0byB5b3UgdG8NCmVuc3VyZSB5b3UgdXNlIHRoZSByaWdodCBvbmUgKG9yIG1peCBhbmQgbWF0
Y2gsIGlmIHlvdSBjYW4pLiBJdCBmZWVscw0KZnVuZGFtZW50YWxseSBtb3JlIHBlcm1pc3NpdmUg
dG8gZGlmZmVyZW50IHR5cGVzIG9mIHNpdHVhdGlvbnMgdGhhbiBmb3JjaW5nIHRoZQ0Kc2tlbCB1
c2VyIHRvIG9ubHkgdXNlIGtlcm5lbCB0eXBlcyBvciByZWZhY3RvciB0aGVpciBwcm9ncmFtIHRv
IGlzb2xhdGUgdGhlDQprZXJuZWwgdHlwZSBsZWFrYWdlIHRvIG9ubHkgdGhlIGNvbXBpbGF0aW9u
IHVuaXQgdXNpbmcgdGhlIHNrZWwuDQo=
