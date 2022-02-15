Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939D84B5F06
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 01:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiBOA07 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 19:26:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiBOA05 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 19:26:57 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30217B3E59
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 16:26:49 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21EKsVpX005712
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 16:26:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=WaxK0vYZTSs7GawnWu6kJ57vcOxRQ0pdugHeZwJmDqw=;
 b=UKaq75/vBhZG5OFS1uoRId5cXIWnPIEUQQWBIq3uIiYLHdKspczxEQZhIRbhz5ezUpB6
 qZoiUVu55CvvZrYlY6ETpVfmIViJfMzefWpuymGR7iYpOvlV90b5sseqsThH3YHYQlLH
 SaPyK+nzEBFr7s1XEKbiKyPp/Il5DYZUQKA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e7rwa4b2a-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 16:26:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 16:26:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBT7D7Pw3gllFdnviFztHKLuNJ0gNWstSuQG8pZOOk9kclPCTgeSHtQ+cqOyakaBOfVeUs/STukB7IqJRqxloUVFSJBN++84pTx0b2sQkGHGRrvPzsezBRVL64HgTHbhzEzokZ4tQrgxpxIypeSaCEDRVGdfYhppMkLXrjgHfnaapeBNOZF/Dyb/VZWV8FfYZErRbJLF3xvjEJJAU6EXED7JA84NUSihaNTlqy97h6qMPN5kFotHlqMxNsNwAjSVYIrh9jaR1T0pVR6eLKpnqbyre38sQIVauR6+g9HwNi0wzLY5TVIpjOhiRfobxIMvPwOsHuH7GeMOvrMJP4+CYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaxK0vYZTSs7GawnWu6kJ57vcOxRQ0pdugHeZwJmDqw=;
 b=Pv9gBn6Pfo90C1ciTNTAosWfwvH2wSTL2h+8hrlSSFrm1y+YwpWnw/0XKEh6s3uZm2nxqnvrP8JEDDvXzSgNl7fQZOCl1oajK9nAdAg0R9u6t21305elBZ/xuGk96x7Ou9lsXf4FuUa6DSUxPtexuNxvnrIbgT5UIPi/gnGMVihUqp/wCMGCiXeiixSKC3bIRpxF5sfEMQavf67eO3PMVbuBMNClaG8PPgG/J46fK/VvfDQt4TxxF1l71xbj4zHXyqDavse8shL9TXdr60DBLz58NJml/vZyVqRkWfMF3abtc+wan7jS2iO2N0OSk4Viq2apzrVCLXuyEPHotEwUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by SA1PR15MB4934.namprd15.prod.outlook.com (2603:10b6:806:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 00:26:41 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7%5]) with mapi id 15.20.4975.012; Tue, 15 Feb 2022
 00:26:41 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 0/1] Avoid size mismatches in skeletons
Thread-Topic: [PATCH bpf-next v2 0/1] Avoid size mismatches in skeletons
Thread-Index: AQHYIgK0od4pyguoI0+AQhHfMcEvxw==
Date:   Tue, 15 Feb 2022 00:26:41 +0000
Message-ID: <cover.1644884357.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbc4d7a9-2e81-4382-127f-08d9f019d696
x-ms-traffictypediagnostic: SA1PR15MB4934:EE_
x-microsoft-antispam-prvs: <SA1PR15MB4934F47C698FDD1343F88963C1349@SA1PR15MB4934.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kpuQmIz6IctCv+O4SR1XqtlCKx0b6LFzhEosYaD35+VuuLIYbVRzpOMsl5bLKjSJgB8X/MJ6JAvdLDGBWAFY6NP8Q0Nz82P9o9JEAZ5ZuVVc0y8OI737Kc2n6JVFgBMdLclI6rctzBqmzrsoascR+pSoeu9wknYZyrYSJrGaMzXv0xb2UojK8i1AyjHdR807c22WHiSfDR8t8lzUS0/AsTz8w68Fqt2PMDtoHiRApusSEWEjIgGiBWU3JN7AZVQUoQHAShDXG4784zjUk/Apeguh3IEtUA8HfSyhUkzX3XqWgkLldLdoyOvcGfSg7DEYUn104E1LViX6dorUwx7Bp7JOJTCVIvdnWs2mfcCVbI8w4/Q7Me9x8V83uDDAs8mYbJBbfSr7L+ArzzCCqpW03Lsv6OXxrTFvbaCnFT2nxTrjbVSpfQxHzqG4WIRWiSNbq5CddPbFV9zQIW+mbePY3hn1maod4KR2lVmXe1iA16tSWqNm9PG0ClIWzyCs1rG4fx2Zl5jXIfO//Ha0b6vdLsjY/zBklN8JgEthyg3v6g+6aI6GzZjP2UU2/vnkL9IPMKy5Cy+CfCPtlxmsERg+ri7WIugVUOZshKunTkFLTTgdKbtsjMomxc76z7yjFziZMwjmWVXxI84wkWSJRuiBD9yE+M3yF5S+PARWeo9CxQiqvto//52n8ud5qxb3sD4XHZZLCVYTdEh1sdhrauBYQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(2906002)(316002)(8676002)(110136005)(66946007)(122000001)(91956017)(66556008)(76116006)(64756008)(66476007)(38100700002)(508600001)(2616005)(8936002)(38070700005)(5660300002)(83380400001)(6512007)(186003)(6486002)(36756003)(86362001)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yQl4ZddIg39kUF2ZZMb9RY+fe9XMUg7Y/GANr+ri/qN5Jn77pmDiDi0qSt?=
 =?iso-8859-1?Q?FHLGTR2q1+Zu6JKqOrE9KVkFh4fkXYsU3A2Jpgdgnnsa8/w921sZi0wgDI?=
 =?iso-8859-1?Q?IpSTgK1rBu7Fn185ezu5zG3prGmgUfp+/qXOFY2IwYS5KBFrqNE+a+i1jY?=
 =?iso-8859-1?Q?w8PnvllHsVl2/lQb1VWywXZL19dmLLqM21T1EHl1nTZURgEVj8H+IyKWEp?=
 =?iso-8859-1?Q?irKFaeSBqdtKW83IJVSSRdgp4dyZURBwj6pRqQRashVjrvtUQOtEJFOoJH?=
 =?iso-8859-1?Q?TyVHnmkXEm/SzyI+VoPdde9tD47iYYHzza+H82/5yXaI8T9uaN4f5myVUI?=
 =?iso-8859-1?Q?YAc8vb9TD+LoS77FHc5U3FJytB4IYMW/HYVSyXzLbPEHCVS3S54zLpHMCn?=
 =?iso-8859-1?Q?O+UBzwn+aBsELz0tF5+bUBXyyQMxiq2O9ZCzpywRbAfNaC4TcMNJhJ40wR?=
 =?iso-8859-1?Q?QPRlc6JJGW3N7lynu4hnjEAhM/mOSqXZt8ZdzABopfUJoAS4XGOFxWCrFn?=
 =?iso-8859-1?Q?a/XFAqCUkSrslC9u2eZrVjZT7f8fMvTxi+RgPDvagS/FgLkN3DfylYLWfv?=
 =?iso-8859-1?Q?wy/PzZIBGdwACEZgBfOddauLzNF2E1niDk1zkRtkAWhpd1p4zNmfAE1m9i?=
 =?iso-8859-1?Q?l3UzVHN8+8peE5pdChSpSi0/grvuFokY/vdgmN9xsf9++2njy3GALQ7O47?=
 =?iso-8859-1?Q?RMHfoJ5Tup20HK554mU8UD8Ynj4fYZAwIYqngCruM25yd/LGZH/kHQKJxH?=
 =?iso-8859-1?Q?5a36sfAE3lUz2aCM4h8zHHQm27WkKN4h0uss0OYRSvrQwqrpx+f4NgY2I1?=
 =?iso-8859-1?Q?A5R/eK4/aB9Kk9OdCMTrTVBwAQ3iDX+uPONltEBcNQWg8JYwZU7H0xTxQ+?=
 =?iso-8859-1?Q?4E2NjAsIILbtXPV8zqY/vcaB+/CNZEuDIqatyNXW2WEJKZ/xuS0MhWtepY?=
 =?iso-8859-1?Q?5/5hPpTmBJ91BnL0cLmxIcJAGin//pxhOJSSA1zeKBOWwjNQijjCnkuk3y?=
 =?iso-8859-1?Q?r+2KWag+u80BS4Mnwkl4CAySzSvXGCpi7rqReKeO1SypG6MwViTadiBmQ6?=
 =?iso-8859-1?Q?rqASJbpyfSilllYvleGVcFfOwYmQmg21r4ZnN2UUSxr38DaK/iZKqNtUig?=
 =?iso-8859-1?Q?MDuYLXgs9ix2Ebz/MU8Sq2hE79YsSgiMQP8fDZGEMMK9XHb7Jv59j7xjq2?=
 =?iso-8859-1?Q?IWPQCTMH/J5g5NCO+M3B71zC7U/ikfZzmWuiIoc/4CpjDTYQQa0AEcUad/?=
 =?iso-8859-1?Q?GvU/SDrjKQaDzq7OjkuaUp1xBtPC8YXxCRUGRtdpWmbs9G+wMVrPKijB86?=
 =?iso-8859-1?Q?BCeiz9hZQA/G7oYnAPHTN4PByhNqB7E5smTP6XV9osgGQPHoh/6M3zyqzL?=
 =?iso-8859-1?Q?u2VoDz/zDckuc1hIz2wAr3QNkY3/QlEJmkKNchJqUdbwqW0mYsuZtGRyD/?=
 =?iso-8859-1?Q?g6xkJ4ZA0ZpoccRcQtSEZTGJyx4tEMDLYU6zBoVZWPS42fsIJWeEtr7AJF?=
 =?iso-8859-1?Q?z4oP+t5osu8XIQwUffYBR/yS6wszXmzYlJT8jlO5BhG2EUkxnzo5TnRq4Y?=
 =?iso-8859-1?Q?cLLfELNyQ12XP2CN9sS3crhp+EIJ3ajDMXhlEF0OSGqU9uY47WnIqjd4Zg?=
 =?iso-8859-1?Q?3SazmMvCJQ4SYTj65MsOQj0acyMJKy/Hk7VeRcF6i40yUJd3acvg2v9g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc4d7a9-2e81-4382-127f-08d9f019d696
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 00:26:41.3862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+H0Ldhuz/NkgpwtwKVlfp1ODn36gx3LzB6wJcLuYsCOMndK8cbDnNiFYOlmk+ga
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4934
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 51duB39V5DwASsWZJeKi4h97dS19mMXx
X-Proofpoint-ORIG-GUID: 51duB39V5DwASsWZJeKi4h97dS19mMXx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_07,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150000
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As reported in [0], kernel and userspace can sometimes disagree
on the size of a type. This leads to trouble when userspace maps the memory=
 of
a bpf program and reads/writes to it assuming a different memory layout.

With this change, the skeletons now contain size asserts to ensure the
types in userspace are compatible in size with the types in the bpf program=
.
In particular, we emit asserts for all top-level fields in the data/rodata/=
bss/etc
structs, but not recursively for the individual members inside - this strik=
es a
compromise between diagnostics precision and still catching all possible si=
ze
mismatches.

The generated asserts are somewhat ugly but are able to handle anonymous st=
ructs:

  struct test_skeleton__data {
          int in1;
          char __pad0[4];
          long long in2;
          int out1;
          char __pad1[4];
          long long out2;
  } *data;
  BPF_STATIC_ASSERT(sizeof(((struct test_skeleton__data*)0)->in1) =3D=3D 4,=
 "unexpe
cted size of field in1");
  BPF_STATIC_ASSERT(sizeof(((struct test_skeleton__data*)0)->in2) =3D=3D 8,=
 "unexpe
cted size of field in2");
  BPF_STATIC_ASSERT(sizeof(((struct test_skeleton__data*)0)->out1) =3D=3D 4=
, "unexp
ected size of field out1");
  BPF_STATIC_ASSERT(sizeof(((struct test_skeleton__data*)0)->out2) =3D=3D 8=
, "unexp
ected size of field out2");
  struct test_skeleton__rodata {
          struct {
                  int in6;
          } in;
  } *rodata;
  BPF_STATIC_ASSERT(sizeof(((struct test_skeleton__rodata*)0)->in) =3D=3D 4=
, "unexp
ected size of field in");

I'm open to pushing more of the ugliness into a macro, I was going primaril=
y for
simplicity in the diagnostic messages (it's unfortunate enough that we need=
 a level
of macro expansion for C++ support). If we need this to be prettier, what's=
 a good
header I could push any extra complexity into, so it's not spelled out in g=
en.c?

Delyan Kratunov (1):
  bpftool: bpf skeletons assert type sizes

 tools/bpf/bpftool/gen.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

--
2.34.1=
