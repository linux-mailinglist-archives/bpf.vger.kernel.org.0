Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06794B19BF
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 00:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243864AbiBJXpo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 18:45:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243829AbiBJXpn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 18:45:43 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89895F6C
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:45:43 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ANSJP7010672
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:45:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=g5UXqZzaXpQBAU22/PnesxMfipaDqDCaMJqGH0pyGyQ=;
 b=Y/ZnTwfYcU4h2+fSq7Z2OgFvwh9ljZA3j9z9IUQTvBZnxJVg5A9IcFrvWMBZjTKbBuB8
 bpg2G2zhYsIiv4iqW2gvbQpkO+5eQOT7SmPnWXu6nsZQd/XPaR+mNAH4cMLedMA3aeOu
 ZW0EsKr02cJCv05P4lCg+Vwr0lWvxpy1WJo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e58e1hxt5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:45:42 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 15:45:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA9lyksneLEAYg4oDDGilkIyZ/FXEZvAhfuUEZr9/MF8At3+wCq+yVh3+mUUSSCJQfi9cVnmAEiaCc8ZOoosVt9As2lxfdJhd5hcFDzNCW/By4bcw9nWWa+lm2IgshKzfKYPoS6BpzbDNpQalglojQumEpz7P6IICmNFpVI7kCp2Z+5T0c7xIERBvZbiRNAdQZRlPCXUDSnzD7qZg7zZLfDdVSOyqKzQMl0e38/+h4Du++HnT8eSCENpHY8A2G5Opwbx+ExTNM1y2/PAzwzM6YTlSWzLs+QS81xJ4xFbb7k8j89ANG9pJSOQC/0H37bUca6jRYLgmPUH4pmuCsrcfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5UXqZzaXpQBAU22/PnesxMfipaDqDCaMJqGH0pyGyQ=;
 b=MetbylpkSqsvEV1fHRfdhUxw7yRbab6axNBI07gzoWVQ/SoQzB+d9XsWcNR9N0+8i5A6J9CQkynNq5yAyolNc601RSXUG8rmfUxMOMaJUnREhaxQlh8Y5Rn2CIajudHoyN6/AmsuYeNAoLjmiQOzdjpaNRr80uc3TUWE0DsITSPrvJ0wiRrKWa4MIyokTxZmD8sOWt1obvy/CLh1KVxu5axzrIxSRVdCg5FoqY05EVWkObP9r9Z80qSmdBJioBRrIX2CzSt4nS2k4vmM68HgDSemFiLw2k0qV6jkhQ5c+z+1TkamKdAU7c/vqRo5r6pmkDB8fkxob3rq31jw1cOkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BN6PR15MB1475.namprd15.prod.outlook.com (2603:10b6:404:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 10 Feb
 2022 23:45:39 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7%5]) with mapi id 15.20.4975.012; Thu, 10 Feb 2022
 23:45:39 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 2/3] bpftool: skeleton uses explicitly sized
 ints
Thread-Topic: [PATCH bpf-next v1 2/3] bpftool: skeleton uses explicitly sized
 ints
Thread-Index: AQHYHhZNCBEWSavV602el/xUZMYEsqyNYrgAgAAQFYA=
Date:   Thu, 10 Feb 2022 23:45:39 +0000
Message-ID: <73ee5895f9c0e572d035aa121f7d0820de95a93b.camel@fb.com>
References: <cover.1644453291.git.delyank@fb.com>
         <b904faaff6e8a04809e722d33e062ad47e97c84e.1644453291.git.delyank@fb.com>
         <CAEf4BzaCRjik0wA+SjOjO8Yp9Nju-2trxCq_y_izQiTnR5qeNQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaCRjik0wA+SjOjO8Yp9Nju-2trxCq_y_izQiTnR5qeNQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 467285cf-aed0-43d0-af5e-08d9ecef715b
x-ms-traffictypediagnostic: BN6PR15MB1475:EE_
x-microsoft-antispam-prvs: <BN6PR15MB14752FAC8CAE95FE39A30CD7C12F9@BN6PR15MB1475.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IvHmAIYpbGPBjB9aj0oqB84RbodJ6oPYytLq3Ru95Gjubym4Efl4cWVcZZHkv+/0GHiihfY+MPgEB5hThgBDUYNHxhUCBffBJC5DIdnHSqxQvg8FgVRACzwPznZnYRnC9jdi4GGdrRUSDdAAa/DaLRzEQ17t/fFrk0gSyAf/yprc4k3yjX/wgSvpn6rWCfImWwjd1sifW16yRL9Nq4p/91PXWUNAzQ/o29/tvqXwwCMoKcIxQ0eb90KcIfb8eHF1h1y2YIJHNuLPcXnduN1mQjouN+0LI5TXlBF61bvHdeZtg59Uf2SXd1fyTPP+QdHzdgVwHAgFjmGEV78BnSXOS2bM3s+3NEIVon0IfDPRX9OEOD5t9eL2n4FEhlIEkKZ9zVfMCgnGaksdib+MTjTascAZLinxqI31e7TkD9438FANaXT3eQBCPBxhSDTjpbOpoXQEoH850s6Np7RGpI0gdv66yCyhy/7SxDkCx2TfevfCLls05Rlq70llreu4UClUIrN2D9PpK8JECmmd8+baO7eetugvwq97h0f2g7/NCCFzZBSwFi8pnr4CjkyiPZ1at8KGwWHaOUQ+ZxwpIjY6HtMaGyPRL0G1NzrfbWyUjcLOJ/8b56MK0LJZui+8+JodIvZ7iE0Ab5x0QPL5VuzYSpjE0cr4eCQKfgGmjm/hXltvCeCVrFh5DzITbtpnZ6M6BiZpiubVf23sxflE66hGyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(6506007)(86362001)(54906003)(71200400001)(6486002)(38100700002)(316002)(8936002)(36756003)(186003)(2906002)(4326008)(38070700005)(122000001)(66446008)(64756008)(66946007)(2616005)(4744005)(6512007)(5660300002)(8676002)(508600001)(66476007)(76116006)(66556008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bytDQVE1L1JJQXE0VktIaXYwYnFaMW1RTzhOWTJ4dW5DKzBZYUo2UE5OSVNZ?=
 =?utf-8?B?cWE5VzlldXN5ME50S0RBSk5KT0oySlRibWdWY0QvTHNNcFhtaUo2RUJXWCsw?=
 =?utf-8?B?MHZ0UVFWY29wQ0gxanlEbEpjb05hcEp1TGVxdDdCcjFBTHpkTTdDSzZzY3h2?=
 =?utf-8?B?c1J6VG43Qm53SkcwQlFBZkh6M3FBR2JJYnJQaUNCRXFISzFOc0I1Z0RBdG94?=
 =?utf-8?B?WWlBd25ZQWlzRTJLcDR3Nm1vQ0tSY1IyUjFYUlM3VlFHbnFWNWNQalJ1TmN5?=
 =?utf-8?B?bHFuaVMxeXpaVmdtcHFZRklWTzN5UGtsc1QvTW9lUDFCUzFZLzZ6QVhNS3Nh?=
 =?utf-8?B?dmhwRnZnZEFpTGVlT25rR2NNem9YaFl2K1lqRk1zWnZ6eCsxSThmWGsvNzAr?=
 =?utf-8?B?Ymd1b3RRRGxsd05FRzUxclFBb0t5ampCc29HdHRETFQ4aWFvYk5OYXJpeGVz?=
 =?utf-8?B?cmFlTTh0QnVINFFXVkl2blNJUzJIQXh4SWVLQXRMc2dnSjNsSVh6cUZFQUw2?=
 =?utf-8?B?R0pEckkwdUw2V1VoWEk3M0YwakUzRGwvQ2x3KzNjenIxVWRQcWkwZjhXVElW?=
 =?utf-8?B?anFEU2xTN2taTGY1QWhVVDM0d1dSTDNTUzkvY2FISzlYMjBMU3Bta0JYeFZC?=
 =?utf-8?B?bEVYNlJ5M0ZkUTFaakZKRUViSzM3ZUtRMFBEZ2gxU3FLaVVaam4vdVFldERI?=
 =?utf-8?B?ZThaL0pqSDBtamEvWEcrRDdYVEFxbFdvTGdtcUMranlvc0loZmNCeXVyTk00?=
 =?utf-8?B?NkhqakdJcFlzWm15T2FtVWdrYzFsbzUzcXJIdzR1d0lXWlFDaWRaQlJmVzA0?=
 =?utf-8?B?N1RISzU0ZTRkQlRETExKVThSR2prakFJQk1SaTFmeTY3YW05WEx1eURObVZL?=
 =?utf-8?B?MzdxdDBtbGg0eEhvZEhtRUl3NlB4T3NJc0dvdVFCTnNwNkdIeFhzUitZakJ5?=
 =?utf-8?B?Wk5Ydjh6Ykd5U25YVlZDNk55QThzQkhBcTkyQ3ZPSHNyS3E0eEhpUEdOejJ6?=
 =?utf-8?B?My81M0lFcWZ3NXRTcHc5VkdPbmZLaVduZ2RuYnhNSzdEVnJ2SjgrUWd2eUVw?=
 =?utf-8?B?UnNQelE0R3F4YWJrd2VudnowektGdnYyTkt1WkRiSzAwWHhXNUZmeDhGVHgx?=
 =?utf-8?B?cWVia2ZtVWxDS1pEUnE5VTBIY2xoNEJJdVhrQXlub3BiUVpsK0RSTHJKU0JY?=
 =?utf-8?B?Z0xjMkRvQ0ZKNmxmcm50ZnliTEYvZERkSkZqTlkyWjI5WjNBMldGZGhYUE9J?=
 =?utf-8?B?enllMGpCOUNYRFRlS1dHMVQ4ckZZMnZXOFpJMURUejhDZWt3SCtZMndadjhD?=
 =?utf-8?B?Y0xtcjJYMVdRRk9iYlgzN3RXdEUyRXUyODFzMVRSN2Z1VzdlRnZjRzdkTWox?=
 =?utf-8?B?WlU0OVRIVWR3aks3T3ZrNWRsQno5aWVQaEFVNHdXcUlWQXJJRFVmM3hFdnJD?=
 =?utf-8?B?LzBUd0NGb284OTlqeWlUc2xGS2hiVnhzeUNmQnVGc3FVcVR5Vm5wK1MybllW?=
 =?utf-8?B?NVU5NjBQSjh0ME5IeFErSndSZGJZbDl5RXVKcnQ1eUpIRmZvZnFhUit0aGsr?=
 =?utf-8?B?allUK3VtZ0Qvb0xBeWhMaFdqNmJDbHNKZ045UFBtVEREcHhOZDdQSkZGTTVm?=
 =?utf-8?B?YmI4TFNCeGFoZDR6RmtXcWxYdU45TTFTVVZOaytKa25QM3N2Z3VOcXl4UGxV?=
 =?utf-8?B?YS9DY1lZMFBmYVcxQnlURHZYd2ptanZUNnVWaWxUL3EyV25zYk8wcnlFZEti?=
 =?utf-8?B?RkxBUlg0VUVPc0VEWHRoa0IySWJHUkV0QktsRVIyNHN6WDBiKy9GOUpmTE9t?=
 =?utf-8?B?ZTF2V0JqcTN0Z2V1bS9nT2ltb1FYV0NRaHErQUdESzhISkwwV2VWQW4xR2Nk?=
 =?utf-8?B?Y2pNaUxXL0MwR1ErdG1oUWZoRHRDZ2xGQ3FGTVA2OHNnVG01d3FlQXFSZk1P?=
 =?utf-8?B?dEpRSElKZ3lTV202MW5vWlBlRkd5QXcwRmpZMFZKVUwrSHY4QUF6N0I0NThC?=
 =?utf-8?B?Y0o1bG1ya2kvbFBvQXVpUko4eXBMREJTNDRUWmpDWm5veVJZVDh3SDVoN3RB?=
 =?utf-8?B?NXdadXNuUi9EV1R6Q3ZHOE84V3pYc0RqaituSncxdG5wL1RzMlJyZy9XMHlm?=
 =?utf-8?B?MUlxMzNOQkJiTWZRWm1XanhlemVUR3Zna2l1bVc5WWc0N2ZWZjJLNTRwbGlC?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7FDB9CD00433548871950DFFEA8F8FA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467285cf-aed0-43d0-af5e-08d9ecef715b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 23:45:39.2340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnIXj5ypkTdT/dPPIoydnvnnNKBbWOPve73c4oJDdqRFy+pRjYLGAHPzC9rSYth7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1475
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 0FPnGPrfvc77c6P2Cpb0g6-QJPixOmVj
X-Proofpoint-ORIG-GUID: 0FPnGPrfvc77c6P2Cpb0g6-QJPixOmVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_11,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 mlxlogscore=457 impostorscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202100122
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

T24gVGh1LCAyMDIyLTAyLTEwIGF0IDE0OjQyIC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IGlmIEFsZXhlaSdzIHBhdGNoIHNldCB3aWxsIGdvIGluIGZpcnN0ICh2ZXJ5IGxpa2VseSks
IHlvdSdsbCBuZWVkIHRvDQo+IHJlYmFzZSBhbmQgbWFrZSBzdXJlIHRoYXQgeW91IGRvbid0IGlu
Y2x1ZGUgZWl0aGVyIGludHR5cGVzLmggb3INCj4gc3RkaW50LmggZm9yIGtlcm5lbCBtb2RlLCBh
cyB0aG9zZSBoZWFkZXJzIGRvbid0IGV4aXN0IHRoZXJlDQoNCkFjay4NCg0KPiBzZWVtcyBsaWtl
IGludHR5cGVzLmgganVzdCBpbmNsdWRlcyBzdGRpbnQuaCwgSSdkIGp1c3QgaW5jbHVkZSBzdGRp
bnQuaCBkaXJlY3RseQ0KDQpZb3UgbmVlZCBpbnR0eXBlcy5oIGZvciB0aGUgUFJJeHh4IGZvcm1h
dCBzcGVjaWZpZXJzIGFuZCBJIGZpZ3VyZWQgdXNlcnMgb2YNCnNrZWxzIGFyZSBub3QgdW5saWtl
bHkgdG8gd2FudCB0byBwcmludCB0aGluZ3MuIEhhcHB5IHRvIG1vdmUgaXQgdG8ganVzdA0Kc3Rk
aW50LmggdGhvdWdoLg0KDQo+IHdlIGRvbid0IHVzZSBQUkl4eHggdWdsaW5lc3MgYW55d2hlcmUg
aW4gc2VsZnRlc3RzIG9yIGxpYmJwZiBjb2RlDQo+IGJhc2UsIGl0IHdvdWxkIGJlIGVhc2llciB0
byBqdXN0IGNvbnZlcnQgdGhpcyB0byBBU1NFUlRfRVEoKQ0KPiANCg0KU3VyZSwgY2FuIGRvLg0K
PiANCg==
