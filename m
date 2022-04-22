Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514DB50AD39
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 03:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443059AbiDVBeO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 21:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348008AbiDVBeM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 21:34:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FF84993F;
        Thu, 21 Apr 2022 18:31:20 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23LNWeeC008604;
        Thu, 21 Apr 2022 18:31:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=hKi+bl+UeKAF5q05x8V8kIDlrI2NOAFqSDC2kIL74sI=;
 b=TRuTG9DJm/eD0UetZG6Jjj+lXeAE+vznmYoikT5cL8mp2wjpzbW2/YkyVoymQ6GUYp4t
 wQQ3Miz1b5ypP/3bPtEQMK5nEe6lEgizxvNaaGR2HjVHB95v2xWxdFnJHzDMwG7PHDjk
 pnmZZcmKb0aO4lX4QnljmfBxkb5j9sQ7sYo= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fka3640dg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 18:31:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zrw75xK+KNzcYz8G2nzDb3Z6l9HsROBdammpilT+jxVp3s0RfiLBtPXGAZdGEoz+cg3DLRC2/1bKcfJ2m9Gx4MFCkLbRWfSLVMaL2Z2LqWcJjFkrjPM4wxs+2S98IxIBMutAo4LOogMNJBM2d4T2PICz6BfB5LaYZH7Zj10yDDEn797QRs5T8ZQ6HrfSlaY285zfsGHkx0J6XN6pVLuolqT/Gq5U0Q7VyM9LOhsH11fRkt78Jm/xfwCGTcV2fCe8gSXJ24dqymDHtjAtTRm8Ge5PjjIa0GKfjuTHk5gtiCtXsSFUp5ySFu2/GX1pFEjHFOGAb0iCzTKM6lKrfzyNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKi+bl+UeKAF5q05x8V8kIDlrI2NOAFqSDC2kIL74sI=;
 b=FE1IZt3h//cYF8UwSmPG8856ZkOxlSroq48HG1KV2wZdeAKbQJpxVVzo/zoOk6hqCRdBgq3eX6SvZ4Q3ic436wcfK6o1aG1mhpni4R0e/TeG6NvzfKaQV3czg6c6Go92mzigZIiquPzxLByTxOzId+KI7x2UBRJnJHw3Xr29pfBr5PgYm7G2IjJcqIdfxanMo2Zacp+e564r4GaMD5xQQOtJTFpq1Yhq73HB4ZCVV7cOCt4UAbXDU23DAP37nZZpLHg6qEHQJp58uk0JMrHnIbkXaA4o2tXrt/tQ5+VC72BcbX5lc6AnUR6zXRMAtmjc7GtIVrRio1m6s8vz5vVA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MWHPR15MB1327.namprd15.prod.outlook.com (2603:10b6:320:24::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 01:31:17 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b%7]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 01:31:17 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
Thread-Topic: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
Thread-Index: AQHYVVFO5makbPGsXEqvzLt6DCKkwaz6mnqAgAAexN2AAAuPAIAAHgIAgAAGqwCAAAquAIAABfyAgAAFG4CAACdvAA==
Date:   Fri, 22 Apr 2022 01:31:17 +0000
Message-ID: <4EA80DBB-4194-4FC4-866F-7088C2107E17@fb.com>
References: <20220421072212.608884-1-song@kernel.org>
 <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
 <CAADnVQKyDwXUMCfmdabbVE0vSGxdpqmWAwHRBqbPLW=LdCnHBQ@mail.gmail.com>
 <CAHk-=whFeBezdSrPy31iYv-UZNnNavymrhqrwCptE4uW8aeaHw@mail.gmail.com>
 <CAPhsuW7M6exGD3C1cPBGjhU0Y5efxtJ3=0BWNnbuH87TgQMzdg@mail.gmail.com>
 <CAHk-=wh1mO5HdrOMTq68WHM51-=jdmQS=KipVYxS+5u3uRc5rg@mail.gmail.com>
 <1A4FF473-0988-48BE-9993-0F5E9F0AAC95@fb.com>
 <CAHk-=wi62LDc5B3DOr5pyVtOUOuLkLzHvmZQApH9q=raqaGkUg@mail.gmail.com>
 <8F788446-899C-4BA3-8236-612A94D98582@fb.com>
 <CAHk-=wgW2vxREeH0Bgr8hGxVavfRsNAX3cyaS9eCcg9A77zhLw@mail.gmail.com>
In-Reply-To: <CAHk-=wgW2vxREeH0Bgr8hGxVavfRsNAX3cyaS9eCcg9A77zhLw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be697105-ccf4-4528-749c-08da23ffcc17
x-ms-traffictypediagnostic: MWHPR15MB1327:EE_
x-microsoft-antispam-prvs: <MWHPR15MB132773B74B1946006094DC42B3F79@MWHPR15MB1327.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Icn8YbJlEVwFN+Htu2noJNJ2Y5z/HKoRMFCO2WCyCArBuWTiy23gygI/lDt5CsLZnxHaHaNpSFRAlfYZ2Zd9P1y1jJnp4pMkfOwMy4Chn9F6Voas6WsWYGuif2r8tN/7tYhGQS3hw+jlgq/yOMppCtCmAnorNLkNvq1KdL7k7WMa3etQjo33BrrOWEWU7EP3JJ/GRlkKxfqdo3M3FRUpFxSysnyMJgrgWbIuBpNR0s9tWdv2S/2lZRlUy5nL1syS2/p5HcHW6Sf8uieC7XztxHGeKjdsScYMfHZZsIZLzLCjyuVyqzWONVVHgBdKhYKn8k/r5eaFYDHJkOyfgu22wyaniBqYYx2hzQp1cKMWb1putuD7fkBToqaEe07bvfGlpquHi2/FFhfn4zggK5XTCAGgQQazxAHkqEL/ennrkZGyoSRLuLVrcISpypjkxN/mlL/vjKxXQ21VfMnV4t4ih8DjCle4Wq4wupcl24kaHE4iz7edhBwTMz3uXZdjA16spYuyrjXJwn4oa/Z1og8IeE9cAS5gsA6HUO8G3mwUirCMFfFeFDuQRI8A0K1b9fQmR/LVewtwiJILeDQRl+PkYSC4RF1IUNTkYEyhMPkOU8temTaE0EKfiaslQcwLFBgsvxtaHQ1w5H0BzbibU4KqK4mtosxTc92EIHJbgXIQ9nq3qjoqrivq0kIDWJznVSm7qxyIw6+MoOgQjo/fSo5PzWqMrkSsE82ufXaohMq+itEdBRl/tsVfoVNz+w7xpY+n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(53546011)(6512007)(38100700002)(6506007)(5660300002)(38070700005)(6486002)(7416002)(4744005)(33656002)(2906002)(122000001)(83380400001)(86362001)(508600001)(2616005)(186003)(316002)(71200400001)(66476007)(66946007)(66446008)(54906003)(36756003)(6916009)(91956017)(76116006)(64756008)(8676002)(66556008)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk52RWdIanZiK3dtOU1YWGZ1Mm9xcDc0N3Z5eG5kRHpLRjUzTmI5RXc4Z05N?=
 =?utf-8?B?YXNPR3h1aFpTZmI5WWJvS0tyRXF1dzFwa0M2MzFqZFk0L2ZQMDdJMVpnMW13?=
 =?utf-8?B?RENpRUtKQ0hPQzNCUFFSbUoyRXBxZDZqSEJkY0lFM2xjcnpzRzBXakJta2pi?=
 =?utf-8?B?MUhSUkNFM1hSdWZOMkdvZDJpVzUrYURyblNYVElqMkZtNVRBYk5yaTJ3ZW50?=
 =?utf-8?B?MHlJVGhjM1ErZTZzcHBnY2xzRFNCeW1Odm1pd3ZuVFJUdzJPeEc4dUFVNll3?=
 =?utf-8?B?VUpOZ2tHOVdKdGZEc1FtaDZFY0E5cFVmcmI5bXRVR05YWDNkQXcwUW53b0Zu?=
 =?utf-8?B?bjgvVmFLQVVzcUR3T2NSSWFDdzhJTlVKT0dmL2EycDR1N3JTZVVMTHNRT29m?=
 =?utf-8?B?SGxudEZBVFRiT3F3R242dVFEWHE0dlhNMjFGYXJHckkvdmYxeXAzWlRqZEZ0?=
 =?utf-8?B?b1hWY1huaVZYVnB5Y0NhWC9WZGs0bjY4NGZRNHNQTGR5RXZQeERpZ3NiYXJP?=
 =?utf-8?B?VGZGT2JKRWY5a2tzaXJNcnYwQlU0amZ3aDJwL0VRS3g4bkw1NzJLQVlzeTJz?=
 =?utf-8?B?YkdzZTdpVDRjRi9rbzVQOWU4RnhIMmFyVVNtMk1TNnhLMkNWdkg2SnpGcXpY?=
 =?utf-8?B?OFNXTjdoSU81QTJPNnB5akQ3aGErT1J2QjhMRXlYZmlkWGUvSCtZekdaSXRU?=
 =?utf-8?B?NGphM1hFWlJBc2dyU0xWVjQ5UzZva0FpL0ZNQjhtY01kSHg4bzdGMng3K1pr?=
 =?utf-8?B?UHN5ZVRmb1NOOHpaWmJZNk5WYnNHVjRYLzNOOUFRbzVXOEFGV3JmVk5KNEdU?=
 =?utf-8?B?Y0lma1FyMzBLODN0dnB4YXpqUEFlWkRrVGc0WGxQTFRiZXRTMlhISXFzMGo4?=
 =?utf-8?B?dDFoMFJMc0xZcEJrQmVjSVZZYnNkVmU2NFk1Z2QxTzdUVFYwVVI2eXdGTDNi?=
 =?utf-8?B?SHZkL2hDK3FhWjBjOXBVZ0o3N3pXWktWcE5GSUR1VmxDdjJOWHZNVDFxeUNn?=
 =?utf-8?B?UVYxd1c4Q0ZPOWUxaE9kRDU2Zk5mcUdONkdwMWxCRktkNU1KUzJ3U1RlNDdx?=
 =?utf-8?B?VlpabFROeXFsbjJLcW9ITjlxci83NVRQREFCQlp3cGFNSSswWEk4WXZZRWF0?=
 =?utf-8?B?bXZXM1ZvbXdjOHhML0o5cVFwSHVDMXhPb0ZCMGlJYkx2Qk1aMy9VM3E2NDFG?=
 =?utf-8?B?clNQTEFTcnhIb3BCUkJQa2JyaFhlSVo2SStVVWlSYjVpMGZBSVV4K3N4Q21C?=
 =?utf-8?B?OVNMeEFZY2oyVFlLNzF0OVM1TWRGeG9Sd2Q5bmJNc2czdTluQzYzZStzQ05j?=
 =?utf-8?B?d09vTmdtbVh0YVV4R09PdzBiZDdsUTlmTWYyNnhUaCt6SHY2QnYwNW1SbFhM?=
 =?utf-8?B?NDRMWXpNZGtOTERiSDJMK0h1UzJXNlAvNDFTMzVxdEJ3VlE0bDM5T24rZEFt?=
 =?utf-8?B?d09tVUVSbjIxemNDOFp0TENodFFHRDR6RGVEbG9vK0VGUEF3OUg0d1BQVS91?=
 =?utf-8?B?Y2lMOTBoQ0xoWHBHY2RQUDFrQXFRNFBZVGsrQldGbEsxRUErTVMySkNvN0Yz?=
 =?utf-8?B?WTZOdGlKYU5MVm1uZDdFQVVYcCtNa25yQ0QySURMSHkxUTJCOW9vVnZ3eFRy?=
 =?utf-8?B?YkpOVUR4ZFdqMTFrMXY5OGdEZ1h4Q1UzSTFHdktSMjhCOVZCcjk3VUlZaStr?=
 =?utf-8?B?Zm16VGtwSUJ3aCtENUxpMmFtUnZQMy9Bd2FsMkg5WnI4K0xrcnlkeC9vbTJL?=
 =?utf-8?B?VHZSZWJQYTUxNmJLbWYwUW54TDZOeW5yZmt3ZHNBODFCcUhRN0ZxT2FpeXZZ?=
 =?utf-8?B?eXo3Rk5weUVUT3dnN3BwdFdORGowcWRYS0hsWFgyVDJHS2JzWGQ0cTk3RE44?=
 =?utf-8?B?bVFQR0xJZWhxQ1hqMTNsbVZaSi9ycVpsOW1TcitjWXZSUWRPMExmWm1RdnRB?=
 =?utf-8?B?RnpJbzVmN2lCUGg4Zmk4Q2hVSUZLYTA1V3IvM3BZbVc0Sm9hZFFMdWZZakVy?=
 =?utf-8?B?TldYcWZXTmFCVWFYNXFkYSt3SkMyb2diaUkybFlZN210QythNlZWeDNCd2Vq?=
 =?utf-8?B?MGFLZ3FjdWFPYjVLZU5JYTV2WmtsVjFsOHJ6YlAvQXROVUx2MTdUM1d0NXMy?=
 =?utf-8?B?dXErcXlQSjFUNTZUUTMrMnd1elZtL1RCSFEvVE1nMCtGOWtpdEhjRGgwNk9F?=
 =?utf-8?B?OVJoc2l6S0JLMXVoZVZZQmUzR1pONEZLYlh5QXp1MGRaYm4rUGhCcTNRV3Jm?=
 =?utf-8?B?b0RTL0kxTVV0YmdWV1pSb2Q2VU1sQU54S3QzN2ZTY2RycFp3SzFlc1lVUjV2?=
 =?utf-8?B?bC9CTVBVM1BnQnVmN05RVWc4ZDJsUGRyVGo3MFdWT0FsYlpZS1hKaWE0MjlG?=
 =?utf-8?Q?EB0IzQ9IUie3/GNHiunmSrZ74/NVOB+lhpgG/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A89EB9A839B79447BDB4C6238472EF92@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be697105-ccf4-4528-749c-08da23ffcc17
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 01:31:17.3755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QXiexeMhr5wAdYvNcQx9y2tvulzREi14xK6rLD66s+7R7Y60CSKSBY5X1A8O33M75UQdair0oVS3MX1uSyeKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1327
X-Proofpoint-ORIG-GUID: btjJTMBgUQ9cSfCSea4e85_A0V2MD3bG
X-Proofpoint-GUID: btjJTMBgUQ9cSfCSea4e85_A0V2MD3bG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_06,2022-04-21_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGkgTGludXMsDQoNCj4gT24gQXByIDIxLCAyMDIyLCBhdCA0OjEwIFBNLCBMaW51cyBUb3J2YWxk
cyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBB
cHIgMjEsIDIwMjIgYXQgMzo1MiBQTSBTb25nIExpdSA8c29uZ2xpdWJyYXZpbmdAZmIuY29tPiB3
cm90ZToNCj4+IA0KPj4gSSB0aGluayB0aGlzIHdvbuKAmXQgd29yaywgYXMgc2V0X21lbW9yeV9y
byBtYWtlcyBhbGwgdGhlIGFsaWFzZXMgb2YNCj4+IHRoZXNlIHBhZ2VzIHJlYWQgb25seS4NCj4g
DQo+IEFyZ2guIEkgdGhvdWdodCB3ZSBvbmx5IGRpZCB0aGF0IGZvciB0aGUgd2hvbGUgbWVtb3J5
IHR5cGUgdGhpbmcNCj4gKGhpc3Rvcnk6IG5hc3R5IG1hY2hpbmUgY2hlY2tzIHBvc3NpYmxlIG9u
IHNvbWUgaGFyZHdhcmUgaWYgeW91IG1peA0KPiBtZW1vcnkgdHlwZXMgZm9yIHRoZSBzYW1lIHBo
eXNpY2FsIHBhZ2Ugd2l0aCB2aXJ0dWFsIG1hcHBpbmdzKSwgYnV0IGlmDQo+IHdlIGRvIGl0IGZv
ciBSTyB0b28sIHRoZW4geWVhaC4NCj4gDQo+IEl0J3Mgc2FkIHRvIHVzZSB0aGF0IGhvcnJpZCBt
YWNoaW5lcnkgZm9yIGJhc2ljYWxseSBub24tbGl2ZSBjb2RlLCBidXQNCj4gd2hhdGV2ZXIuDQoN
CkkgZ3Vlc3Mgd2Ugd2lsbCBzdGljayB3aXRoIGJwZl9hcmNoX3RleHRfY29weSgpLCBhbmQgd2Ug
d2lsbCBrZWVwIHRoZSANCkludmFsaWRhdGlvbiBhdCBCUEYgcHJvZ3JhbSBmcmVlIHRpbWU/DQoN
Ckkgd2lsbCByZW9yZGVyIGFuZCByZXNlbmQgcGVuZGluZyBwYXRjaGVzLiBUaGVuIHdlIGNhbiBk
ZWNpZGUgd2hpY2ggb25lcw0KdG8gc2hpcCB3aXRoIDUuMTguIA0KDQpUaGFua3MsDQpTb25n
