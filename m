Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572EF5A58E8
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 03:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiH3Bkj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 21:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH3Bki (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 21:40:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271EE74E08
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 18:40:36 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMpKWx013459
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 18:40:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=JY4D18pzgj4Vd5KEDD/knRayIDa3vW0bbLf7Q8FtOOQ=;
 b=JuibWIIhjI1KdAo69eJmaoq/SgtAAHCsmztN7ZeAHTJxIeolqUzDqVr7MZq8gVd/kl8Q
 QS208BFUrrwmtAv4CrVnmrq6G4XebP8Ul/V9Y9UDRtMuIBhIn1Ien1UnEqOgYM/mNwnm
 /B1UyD8krdUFnQQN/aMhqZUw1aqDFMuUuGQ= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7fakp0et-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 18:40:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWGvgBChdMVFp4S3MeuAdciqsBy87YwriD09E6ddLlAQ/lt5siEmPn8dA3n+U9vymyOndllq5H5Qq8+KNsq70w/rxxFH4c4FDABbmp/lhgnkR9QftMTnvlPw7nijsWntIAiRgbX9OfnpSOwzi6V0Ka8ove65Vr8ghjD28mV1lfAIroS9Otl2PidKdJ03IXk9Ud2WJvFR9NGi69Z0IqMhcXdUhQZvOuEGGY0ADl1Te7lDDcPqOV03yaGZmDmnYthB9fsXt5iRxgngRoRe6uuAyQtDoX1rI3UVwRXlMuU1YsAUeWe3gfPUgUE4y2g7zTpuBWQelEtKkGQleBdtIg3RkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JY4D18pzgj4Vd5KEDD/knRayIDa3vW0bbLf7Q8FtOOQ=;
 b=mzEEuiSR+xhYtC9MNDr2fy+TStFbSXIsooegv2tH+4VPp37Q5RTJUrROr51SuXSRb+k+41Plv/keUv13ReEbYK0uQ/89L/FW46CADwpO26yCDiiKJmRr7Vw7zEvkTCRT3VPxVg8fnpzjG0e3MD4AgEbaD/JXoCdspN6ZX3B4R+lbs25rMijQ/lDHUEmcQ9Tl1kF5/4sxT8ELwKBNoYXdq9X9VB3EtodE8Hhp+FKoas0QWcxzjc1n5lOOyq05N43SKs3cE42+cRsL4ESUIic5liooBBskE4GNBXDQXWvmJFj7HxAFovdlDgVai1YdmVbgu9ZaT+NaGO08UmbBqBTuNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MW4PR15MB4460.namprd15.prod.outlook.com (2603:10b6:303:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 01:40:33 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f830:c4f2:86dc:9b4]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f830:c4f2:86dc:9b4%8]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 01:40:33 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "memxor@gmail.com" <memxor@gmail.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
Thread-Topic: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
Thread-Index: AQHYuB2D39OSH+rKI0eOgpEXWGYdfK3AkV6AgAXZ6gCAAAvjgIAAE9SAgAAHqQCAAAmYAIAAAa6AgAAFQ4CAAAXNAIAACbqA
Date:   Tue, 30 Aug 2022 01:40:32 +0000
Message-ID: <1e05c903cc12d3dd9e53cb96698a18d12d8c6927.camel@fb.com>
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
         <d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com>
         <CAP01T75G-gp2hymxO+x4=3cJ9CHJKsD3DHPn5QbvOL_-o_4qmA@mail.gmail.com>
         <32a60d8aa6414af288b00a222a019bd3932eb7d2.camel@fb.com>
         <CAP01T74nPCXAeP=Aj09pW_Ykv5Rx2Y4U_fULQe+a4pWygVxaGg@mail.gmail.com>
         <5254e00f409cff1e0b8655aeb673b8f77dab21fe.camel@fb.com>
         <CAADnVQL9g=PQzZK06FVOiCPBkM15AuyR6m0K5n5d8GtPBKnNAg@mail.gmail.com>
         <CAP01T76MUhBcWyTnCBMZ9e0xV3i00XZQBjVAnYrVab_Hgqhx5w@mail.gmail.com>
         <CAADnVQLXji_sK8rURTeJJzoM4E40iXNKeEwfK-bB-CMUZcz90Q@mail.gmail.com>
         <CAP01T746jPM1r=fSVJBG-iW=pQAW8JAzLzocnB_GDkb3HKZ+Aw@mail.gmail.com>
         <CAADnVQKAG80STa=iHTBT8NpQWBw=3Hs8nRwq6Vy=zOLjP8YHqw@mail.gmail.com>
In-Reply-To: <CAADnVQKAG80STa=iHTBT8NpQWBw=3Hs8nRwq6Vy=zOLjP8YHqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1963d765-e880-4615-ce13-08da8a28a101
x-ms-traffictypediagnostic: MW4PR15MB4460:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1vq+bx757XZmzc9asSXQ3Ckps1xa6MPFmD+Z0hAYI3LNBCjRCbIDcPVXxORgmPBFJFoxrQxm6fEimAlIIUG8s2tpknCUmH4pwEG5v8rqLVOJb/AMtoGYimfyY4M9vqmbFtd+YYTBQh7IjZ4VdontMXG+BQWIr1Vi3QAo9rwkmERthwywlx6oHW89dOvBxYje/O4Fq+zvE/AnEkVF8HzXpZFhmuakZ4WNYjiIeBy1yx4b5ST5ZYzs4MPkMbfZ9bofWSh7SYucWCt0dzmyoTKa85s1VW3BCbu5hMz5hTjLP6TGtRCbTYFidxr2hSFF+9MT1TefpDq1CLXLQeTL2tGjKatD/ETvopMNSpqk5V2JgJfxwvKMGfejrUkgFarkloFWl6v171Ul3qrj5N0XvQfXzicFmTfRJcHhDSmVfIhzFiAcrt6mh/OcL+5eXalh/V2Y8MlEn6usGr1O9wWTb+hNbJPYy6tKZYQ6+614+RqTRbWrZfPfFCFoq4BWdCnsG/mnjd+Bzn9I7rYUeoiJTb0zhtQNYRgcT+9jdmWCmhB88E0SUup6Pg116xhyRv4JYW1yQQcU97ueGtIOwWmFNBiY2SnUz2IChRIPN59Ds4vsbYpqFlw2u9WwO+KNFn80DF+JfIdNOkBrweMDsAJydfk7NATAhgA+/7LzW+7r6Vds2lx0AwFdtYNnbbHfQgzGKGVEx5Qod6T4/SaUDpPbxackOF4C+PmojA1J/zgyz8pKNImlPgUXAWSodOhbs0K2iy7a02GDUfjgFjWI2SCCUqk+rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(38070700005)(83380400001)(86362001)(2616005)(122000001)(186003)(5660300002)(38100700002)(36756003)(66946007)(4326008)(8676002)(66556008)(66476007)(6506007)(64756008)(2906002)(76116006)(66446008)(6486002)(41300700001)(71200400001)(478600001)(110136005)(53546011)(6512007)(8936002)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWRxcUhzWGJ5cE5nQlh3VEtLTktxQzVZYWNOTXdhelhlWSszSEZUQ3FxTEwx?=
 =?utf-8?B?TVIzcTJ1eXNDL0FKVzQ4YS9IODIyUW8zSU1xV044UGt1bVRYUHRxNVdOWmln?=
 =?utf-8?B?c0Rwd3JCcXJVb1NMQjkrRXkzWnAzN21GTVZiZDVXK3dDaldacFZvRzJzUmh5?=
 =?utf-8?B?cGt3ZnZHOU9OaDhUV3lOU01NSkFUV3laeC85ZWVaaWNLbkdRKy9aRXFML1ZI?=
 =?utf-8?B?bCtZaGN6N3JPN2l5NnV3d0JrSmxGSHFLU2plQStwOUp0VzhzR2I4QU1zT0cz?=
 =?utf-8?B?c1haRVo5VVBlV1cyR2V1QmVuaTcvTEJGdjZGOHh6eFdUWmV4dzV5T1hReW9m?=
 =?utf-8?B?L0JqZlo0YU1lRVNpL0ZEaHRiY0tPZWVhanFEL0lZaVlQNlQrcFVFallhdzIr?=
 =?utf-8?B?RC94RmtOdU5KUHpDUmtDSE5seGZIci9MTHBtaVkwa0NERzRoWW8rb0ErUmEr?=
 =?utf-8?B?MG1JM0ZkeXh1K0JadzVmQWFlWmtJekpJdWx0eFhTUmhlWnhia1ExZ2NjT3BY?=
 =?utf-8?B?dFVxaEdBNURaTXNteVM3RlU1T1RXNFBDak85bHZBQk5yOXhEUGR0MTl2andU?=
 =?utf-8?B?Q3RiVHpFNXh5UnJDdXhLRTNkRFFYY015MEVGeXI1ZHlVdGc0cVlVM3pPSFdo?=
 =?utf-8?B?NERpU0lsRHdQcndIRURJWWdWRTZHajNnZllkekZvYjhkanExS1J2aERONzR0?=
 =?utf-8?B?MXFYZUZIOUlyK1RQYWpoWjc2VW4wd3FnaEk1NVBEajZpQnA4cSs3SzdOY2oy?=
 =?utf-8?B?VjhFRjlQTFBlcUk2Z2gwM2hIZERhZDhFS0FTd1E0cVdENlhLL1Z5NGRVK2lu?=
 =?utf-8?B?MXQ5QzJWUmdleUphYjRMSDdacDd1Ky9naERDcDBoNEFEUXg2NUNUR1R3ZDJu?=
 =?utf-8?B?RDlhQU5sZUlsd2phTzJ4TEpscU5XMXZuRC85a2dYV1lEQ2xib3BzTDI0ZjdK?=
 =?utf-8?B?SjVXMkpSb1BnNFdLZFNaR0UvNXVFS2U3cmoxV05NWHdMVWZJM3hUelM2TElt?=
 =?utf-8?B?R1ltUTJHMXJkQ0NMV3YrSkcvSHlKSlZIOGRkQUw1VmFBUUYzS1ZMSHlDdFRw?=
 =?utf-8?B?aUtwWEo5eHF6MzhWd2hlTEM0KzVLSDd6OTBVYzRCUlFrWnFGdFYxUktxNkRp?=
 =?utf-8?B?SGw4Y1dVVlQ4NUo1cGVVUXpsUFZ6K1VhMXFyaEVXWHYvZmxSWFhiU0krZjVT?=
 =?utf-8?B?cWtqWTAxVFJTbTJPWUtmMU9Fai9oWTJDMjBOT1hkQ2JTcm5wS1Q3SndDR3R0?=
 =?utf-8?B?cGhvM29uUUNDYzRZUmpQekFnRUJ2bVRSQ3lHdE12ME5PUjNIVnozN2ZiNkZt?=
 =?utf-8?B?QWhSdHc1a240bXdBRjYxQ3ZYMG83N3JSSFowUXV3MVNQUWU3T2ovRFFhMjlR?=
 =?utf-8?B?UG9pczJBNHMyY0pSUjNhdFc0aDhwSWhadmlBSTJhcGdmaDl0eGVEU2IyRUVu?=
 =?utf-8?B?RHVqcnEzSGJUY1JHNVNMc3RPT1RIZEdCM0xpSHhpM0MwMURVemRWYjBZQVox?=
 =?utf-8?B?eTZhaUZRcC9UdllITjNrV2QxU3hKc1dtaXNNUXBNVmppa3I5ZnFhdkRCQkpE?=
 =?utf-8?B?cktaeVZGTzVoYlhLdkR4ZE4vQmRROFBmUlppbmZBZ3ZyT3UrK2pQaG53LzVN?=
 =?utf-8?B?Z0hSelF4Snp4cEM3SzFIUS9BbEpYZTRaanNZSUEzVUhnRWxMZHJSUmZ1Sjc2?=
 =?utf-8?B?TVR6aENsanh2ekhJNXNsQStOaHdLeTBOdjBYdVJIOEY2cUN2RFVtSkJxemg3?=
 =?utf-8?B?QzdCbnc0aGN5blJBQjBVeUpFcDJicFFNSkpRdzUyYVdxeUw3Ny93dXVoTWlG?=
 =?utf-8?B?UG9HdmRuOUF0K1FCS0FJRzV2QzZCRFdlUStmUElGbFpsSkhHSWorTnBSWUFR?=
 =?utf-8?B?NTVGRVU3T0NGcWlFUzgwZjVPK0NZMnJQUVdqMHVOL25SU1NndE1NZDE1UU1x?=
 =?utf-8?B?NFpMV3FibmVRZXlZQnBjV2pVRWk2RDh0Z1hqQkllM21hdmhSTDZlWnFuUzFE?=
 =?utf-8?B?MjlNSll2eDRRc1VSMFpWMzBodDdxT0o5OGxuMU9YWTFJUHZVNyt2emZGNTQ0?=
 =?utf-8?B?SE1rU3c1QVFYVk9EOG5kbjhTeC9JMXdZOC9GRHRQa3dYa3dvcnBMQWJpVHkz?=
 =?utf-8?B?anVoV21zNm9rWFZEQXFqa2pSVXJpUmNLV3NyQzJxYzhuak1pbmRmZzhMSURC?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <424A12923ED3294EBB0B4658A506A7C5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1963d765-e880-4615-ce13-08da8a28a101
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 01:40:33.0609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L0WbxcIAWvdNVfU6q4Y3ZafZSGoNAYaHf12Fk/cU4zrd1lJlKvIn8g9AO+gzV6E3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4460
X-Proofpoint-ORIG-GUID: TmS4OEfEwmqsZu3vkZEjHa47NQ2vrQA7
X-Proofpoint-GUID: TmS4OEfEwmqsZu3vkZEjHa47NQ2vrQA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_13,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTI5IGF0IDE4OjA1IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgIFRoaXMgTWVzc2FnZSBJcyBGcm9tIGFuIEV4dGVybmFs
IFNlbmRlcg0KPiANCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gT24gTW9uLCBBdWcgMjksIDIwMjIg
YXQgNTo0NSBQTSBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaQ0KPiA8bWVteG9yQGdtYWlsLmNvbT4g
d3JvdGU6DQo+ID4gDQo+ID4gT24gVHVlLCAzMCBBdWcgMjAyMiBhdCAwMjoyNiwgQWxleGVpIFN0
YXJvdm9pdG92DQo+ID4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+
ID4gDQo+ID4gPiBPbiBNb24sIEF1ZyAyOSwgMjAyMiBhdCA1OjIwIFBNIEt1bWFyIEthcnRpa2V5
YSBEd2l2ZWRpDQo+ID4gPiA8bWVteG9yQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+
ID4gPiBPbiBUdWUsIDMwIEF1ZyAyMDIyIGF0IDAxOjQ1LCBBbGV4ZWkgU3Rhcm92b2l0b3YNCj4g
PiA+ID4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IE9uIE1vbiwgQXVnIDI5LCAyMDIyIGF0IDQ6MTggUE0gRGVseWFuIEtyYXR1bm92
IDxkZWx5YW5rQGZiLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+IEl0IGlzIG5vdCB2ZXJ5IHByZWNpc2UsIGJ1dCB1bnRpbCB0aG9zZSBtYXBz
IGFyZSBnb25lIGl0IGRlbGF5cw0KPiA+ID4gPiA+ID4gPiByZWxlYXNlIG9mIHRoZSBhbGxvY2F0
b3IgKHdlIGNhbiBlbXB0eSBhbGwgcGVyY3B1IGNhY2hlcyB0byBzYXZlDQo+ID4gPiA+ID4gPiA+
IG1lbW9yeSBvbmNlIGJwZl9tYXAgcGlubmluZyB0aGUgYWxsb2NhdG9yIGlzIGdvbmUsIGJlY2F1
c2UgYWxsb2NhdGlvbnMNCj4gPiA+ID4gPiA+ID4gYXJlIG5vdCBnb2luZyB0byBiZSBzZXJ2ZWQp
LiBCdXQgaXQgYWxsb3dzIHVuaXRfZnJlZSB0byBiZSByZWxhdGl2ZWx5DQo+ID4gPiA+ID4gPiA+
IGxlc3MgY29zdGx5IGFzIGxvbmcgYXMgdGhvc2UgJ2NhbmRpZGF0ZScgbWFwcyBhcmUgYXJvdW5k
Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBZZXMsIHdlIGNvbnNpZGVyZWQgdGhpcyBidXQg
aXQncyBtdWNoIGVhc2llciB0byBnZXQgdG8gcGF0aG9sb2dpY2FsIGJlaGF2aW9ycywgYnkNCj4g
PiA+ID4gPiA+IGp1c3QgbG9hZGluZyBhbmQgdW5sb2FkaW5nIHByb2dyYW1zIHRoYXQgY2FuIGFj
Y2VzcyBhbiBhbGxvY2F0b3IgaW4gYSBsb29wLiBUaGUNCj4gPiA+ID4gPiA+IGZyZWVsaXN0cyBi
ZWluZyBlbXB0eSBoZWxwIGJ1dCBpdCdzIHN0aWxsIHF1aXRlIGVhc3kgdG8gaG9sZCBhIGxvdCBv
ZiBtZW1vcnkgZm9yDQo+ID4gPiA+ID4gPiBub3RoaW5nLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBUaGUgcG9pbnRlciB3YWxrIHdhcyBwcm9wb3NlZCB0byBwcnVuZSBtb3N0IHN1Y2ggcGF0
aG9sb2dpY2FsIGNhc2VzIHdoaWxlIHN0aWxsIGJlaW5nDQo+ID4gPiA+ID4gPiBjb25zZXJ2YXRp
dmUgZW5vdWdoIHRvIGJlIGVhc3kgdG8gaW1wbGVtZW50LiBPbmx5IHJhY2VzIHdpdGggdGhlIHBv
aW50ZXIgd2FsayBjYW4NCj4gPiA+ID4gPiA+IGV4dGVuZCB0aGUgbGlmZXRpbWUgdW5uZWNlc3Nh
cmlseS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJJ20gZ2V0dGluZyBsb3N0IGluIHRoaXMgdGhy
ZWFkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEhlcmUgaXMgbXkgdW5kZXJzdGFuZGluZyBzbyBm
YXI6DQo+ID4gPiA+ID4gV2UgZG9uJ3QgZnJlZSBrZXJuZWwga3B0cnMgZnJvbSBtYXAgaW4gcmVs
ZWFzZV91cmVmLA0KPiA+ID4gPiA+IGJ1dCB3ZSBzaG91bGQgZm9yIGxvY2FsIGtwdHJzLCBzaW5j
ZSBzdWNoIG9ianMgYXJlDQo+ID4gPiA+ID4gbm90IG11Y2ggZGlmZmVyZW50IGZyb20gdGltZXJz
Lg0KPiA+ID4gPiA+IFNvIHJlbGVhc2VfdXJlZiB3aWxsIHhjaGcgYWxsIHN1Y2gga3B0cnMgYW5k
IGZyZWUgdGhlbQ0KPiA+ID4gPiA+IGludG8gdGhlIGFsbG9jYXRvciB3aXRob3V0IHRvdWNoaW5n
IGFsbG9jYXRvcidzIHJlZmNudC4NCj4gPiA+ID4gPiBTbyB0aGVyZSBpcyBubyBjb25jdXJyZW5j
eSBpc3N1ZSB0aGF0IEt1bWFyIHdhcyBjb25jZXJuZWQgYWJvdXQuDQpZZXMsIGlmIHdlIHBvcHVs
YXRlIHVzZWRfYWxsb2NhdG9ycyBvbiBsb2FkIGFuZCBjb3B5IHRoZW0gdG8gaW5uZXIgbWFwcywg
dGhpcyBtaWdodA0Kd29yay4gSXQgcmVxdWlyZXMgdGhlIG1vc3QgY29uc2VydmF0aXZlIGFwcHJv
YWNoIHdoZXJlIGxvYWRpbmcgYW5kIHVubG9hZGluZyBhDQpwcm9ncmFtIGluIGEgbG9vcCB3b3Vs
ZCBhZGQgaXRzIGFsbG9jYXRvcnMgdG8gdGhlIHZpc2libGUgcGlubmVkIG1hcHMsIGFjY3VtdWxh
dGluZw0KYWxsb2NhdG9ycyB3ZSBjYW4ndCByZWxlYXNlIHVudGlsIHRoZSBtYXAgaXMgZ29uZS4N
Cg0KSG93ZXZlciwgSSB0aG91Z2h0IHlvdSB3YW50ZWQgdG8gd2FsayB0aGUgdmFsdWVzIGluc3Rl
YWQgdG8gcHJldmVudCB0aGlzIGFidXNlLiBBdA0KbGVhc3QgdGhhdCdzIHRoZSB1bmRlcnN0YW5k
aW5nIEkgd2FzIG9wZXJhdGluZyB1bmRlci4NCg0KSWYgYSBwcm9ncmFtIGhhcyB0aGUgbWF4IG51
bWJlciBvZiBwb3NzaWJsZSBhbGxvY2F0b3JzIGFuZCB3ZSBqdXN0IGxvYWQvdW5sb2FkIGl0IGlu
DQphIGxvb3AsIHdpdGggYSB2aXNpYmxlIHBpbm5lZCBtYXAsIHRoZSB1c2VkX2FsbG9jYXRvcnMg
bGlzdCBvZiB0aGF0IG1hcCBjYW4gZWFzaWx5DQpza3lyb2NrZXQuIFRoaXMgaXMgYSBwcm9ibGVt
IGluIGl0c2VsZiwgaW4gdGhhdCBpdCBuZWVkcyB0byBncm93IGR5bmFtaWNhbGx5IChwcm9ncmFt
DQpsb2FkL3VubG9hZCBpcyBhIGdvb2QgY29udGV4dCB0byBkbyB0aGF0IGZyb20gYnV0IGlubmVy
IG1hcCBpbnNlcnQvZGVsZXRlIGNhbiBhbHNvDQpncm93IHRoZSBsaXN0IGFuZCB0aGF0J3MgaW4g
YSBiYWQgY29udGV4dCBwb3RlbnRpYWxseSkuDQoNCj4gPiA+ID4gDQo+ID4gPiA+IEhhdmVuJ3Qg
cmVhbGx5IHRob3VnaHQgdGhyb3VnaCB3aGV0aGVyIHRoaXMgd2lsbCBmaXggdGhlIGNvbmN1cnJl
bnQNCj4gPiA+ID4ga3B0ciBzd2FwIHByb2JsZW0sIGJ1dCB0aGVuIHdpdGggdGhpcyBJIHRoaW5r
IHlvdSBuZWVkOg0KPiA+ID4gPiAtIE5ldyBoZWxwZXIgYnBmX2xvY2FsX2twdHJfeGNoZyhtYXAs
IG1hcF92YWx1ZSwga3B0cikNCj4gPiA+IA0KPiA+ID4gbm8uIHdoeT8NCj4gPiA+IGN1cnJlbnQg
YnBmX2twdHJfeGNoZyh2b2lkICptYXBfdmFsdWUsIHZvaWQgKnB0cikgc2hvdWxkIHdvcmsuDQo+
ID4gPiBUaGUgdmVyaWZpZXIga25vd3MgbWFwIHB0ciBmcm9tIG1hcF92YWx1ZS4NCj4gPiA+IA0K
PiA+ID4gPiAtIEFzc29jaWF0aW5nIG1hcF91aWQgb2YgbWFwLCBtYXBfdmFsdWUNCj4gPiA+ID4g
LSBBbHdheXMgZG9pbmcgYXRvbWljX2luY19ub3RfemVybyhtYXAtPnVzZXJjbnQpIGZvciBlYWNo
IGNhbGwgdG8NCj4gPiA+ID4gbG9jYWxfa3B0cl94Y2hnDQo+ID4gPiA+IDEgYW5kIDIgYmVjYXVz
ZSBvZiBpbm5lcl9tYXBzLCAzIGJlY2F1c2Ugb2YgcmVsZWFzZV91cmVmLg0KPiA+ID4gPiBCdXQg
bWF5YmUgbm90IGEgZGVhbCBicmVha2VyPw0KPiA+ID4gDQo+ID4gPiBObyBydW4tdGltZSByZWZj
bnRzLg0KPiA+IA0KPiA+IEhvdyBpcyBmdXR1cmUga3B0cl94Y2hnIHByZXZlbnRlZCBmb3IgdGhl
IG1hcCBhZnRlciBpdHMgdXNlcmNudCBkcm9wcyB0byAwPw0KPiA+IElmIHdlIGRvbid0IGNoZWNr
IGl0IGF0IHJ1bnRpbWUgd2UgY2FuIHhjaGcgaW4gbm9uLU5VTEwga3B0ciBhZnRlcg0KPiA+IHJl
bGVhc2VfdXJlZiBjYWxsYmFjay4NCj4gPiBGb3IgdGltZXIgeW91IGFyZSB0YWtpbmcgdGltZXIg
c3BpbmxvY2sgYW5kIHJlYWRpbmcgbWFwLT51c2VyY250IGluDQo+ID4gdGltZXJfc2V0X2NhbGxi
YWNrLg0KPiANCj4gU29ycnkgSSBjb25mdXNlZCBteXNlbGYgYW5kIG90aGVycyB3aXRoIHJlbGVh
c2VfdXJlZi4NCj4gSSBtZWFudCBtYXBfcG9rZV91bnRyYWNrLWxpa2UgY2FsbC4NCj4gV2hlbiB3
ZSBkcm9wIHJlZnMgZnJvbSB1c2VkIG1hcHMgaW4gX19icGZfZnJlZV91c2VkX21hcHMNCj4gd2Ug
d2FsayBhbGwgZWxlbWVudHMuDQo+IFNpbWlsYXIgaWRlYSBoZXJlLg0KPiBXaGVuIHByb2cgaXMg
dW5sb2FkZWQgaXQgY2xlYW5zIHVwIGFsbCBvYmplY3RzIGl0IGFsbG9jYXRlZA0KPiBhbmQgc3Rv
cmVkIGludG8gbWFwcyBiZWZvcmUgZHJvcHBpbmcgcmVmY250LXMNCj4gaW4gcHJvZy0+dXNlZF9h
bGxvY2F0b3JzLg0KDQpGb3IgYW4gYWxsb2NhdG9yIHRoYXQncyB2aXNpYmxlIGZyb20gbXVsdGlw
bGUgcHJvZ3JhbXMgKHNheSwgaXQncyBpbiBhIG1hcC1vZi1tYXBzKSwNCmhvdyB3b3VsZCB3ZSBr
bm93IHdoaWNoIHZhbHVlcyB3ZXJlIGFsbG9jYXRlZCBieSB3aGljaCBwcm9ncmFtPyBEbyB3ZSBm
b3JiaWQgc2hhcmVkDQphbGxvY2F0b3JzIG91dHJpZ2h0PyBJIGNhbiBpbWFnaW5lIGNvbnRhaW5l
ciBhZ2VudC1saWtlIHNvZnR3YXJlIHdhbnRpbmcgdG8gcmV1c2UgaXRzDQphbGxvY2F0b3IgY2Fj
aGVzIGZyb20gYSBwcmV2aW91cyBydW4uDQoNCkJlc2lkZXMsIGNsZWFuaW5nIHVwIHRoZSB2YWx1
ZXMgaXMgdGhlIGVhc3kgcGFydCAtIHNvIGxvbmcgYXMgdGhlIG1hcCBpcyBleHRlbmRpbmcNCnRo
ZSBhbGxvY2F0b3IncyBsaWZldGltZSwgdGhpcyBpcyBzYWZlLCB3ZSBjYW4gZXZlbiB1c2UgdGhl
IGtwdHIgZGVzdHJ1Y3RvciBtZWNoYW5pc20NCih0aG91Z2ggSSdkIHJhdGhlciBub3QpLg0KDQpU
aGVyZSBhcmUgdGhyZWUgbWFpbiBjYXNlcyBvZiBsaWZldGltZSBleHRlbnNpb246DQoxKSBEaXJl
Y3RseSB2aXNpYmxlIG1hcHMgLSBub3JtYWwgdXNlZF9hbGxvY2F0b3JzIHdpdGggb3Igd2l0aG91
dCBhIHdhbGsgd29ya3MgaGVyZS4NCjIpIElubmVyIG1hcHMuIEkgcGxhbiB0byBzdHJhaWdodCB1
cCBkaXNhbGxvdyB0aGVpciBpbnNlcnRpb24gaWYgdGhleSBoYXZlIGENCmtwdHJfbG9jYWwgZmll
bGQuIElmIHNvbWVvbmUgbmVlZHMgdGhpcywgd2UgY2FuIHNvbHZlIGl0IHRoZW4sIGl0J3MgdG9v
IGhhcmQgdG8gZG8NCnRoZSB1bmlvbiBvZiBsaXN0cyBsb2dpYyBjbGVhbmx5IGZvciBhIHYxLg0K
MykgU3RhY2sgb2YgYW5vdGhlciBwcm9ncmFtLiBJJ20gbm90IHN1cmUgaG93IHRvIHJlcXVpcmUg
dGhhdCBwcm9ncmFtcyB3aXRoDQprcHRyX2xvY2FsIGRvIG5vdCB1c2UgdGhlIHNhbWUgYnRmIHN0
cnVjdHMgYnV0IGlmIHRoYXQncyBwb3NzaWJsZSwgdGhpcyBjYW4gbmF0dXJhbGx5DQpiZSBkaXNh
bGxvd2VkIHZpYSB0aGUgYnRmIGNvbXBhcmlzb25zIGZhaWxpbmcgKGl0J3MgYW5vdGhlciBjYXNl
IG9mIGJ0ZiBkb21haW4NCmNyb3Nzb3ZlcikuIE1heWJlIHdlIHRhZyB0aGUgYnRmIHN0cnVjdCBh
cyBjb250YWluaW5nIGxvY2FsIGtwdHIgdHlwZSB0YWdzIGFuZA0KZGlzYWxsb3cgaXRzIHVzZSBm
b3IgbW9yZSB0aGFuIG9uZSBwcm9ncmFtPw0KDQpTZXBhcmF0ZWx5LCBJIHRoaW5rIEkganVzdCB3
b24ndCBhbGxvdyBhbGxvY2F0b3JzIGFzIGlubmVyIG1hcHMsIHRoYXQncyBmb3IgYW5vdGhlcg0K
ZGF5IHRvbyAodGhvdWdoIGl0IG1heSB3b3JrIGp1c3QgZmluZSkuDQoNClBlcmZlY3QsIGVuZW15
IG9mIHRoZSBnb29kLCBzb21ldGhpbmctc29tZXRoaW5nLg0KDQotLSBEZWx5YW4NCg==
