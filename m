Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B08D4B01FF
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 02:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiBJBXH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 20:23:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiBJBXH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 20:23:07 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC3E1EC73
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 17:23:09 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219NYHi7029395
        for <bpf@vger.kernel.org>; Wed, 9 Feb 2022 16:36:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=52IBIjjQ+6L0KcLPzXAok+yxZUswRt4TXhrE7fPx10s=;
 b=WE/7mNdKbN1PlWI/R39NFdZLUdWxJRhPtzpKHq0+/gkwaXnPsqqqy/+mGNQMj8ffZMy4
 xcBiUoLTF3bIz3lnSfaIIAnXA13zqa7BLHHKYtNI96dBcYvNPNzGQL4oFHXJ7j+vFhSO
 dYICicePTyqXzo+FZd3tuopSwi6SIS3jMR0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e4e8nvnfh-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 16:36:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 16:36:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgQ/R5No8PKxM2Yd6WVDCfVKFN+Bs+lxH7kgjxhD2mURJerzhy7Lf8dZHpLhjAxxfLoCQkyHhCgaiOVI+zYq++2SjkG3A60PUmBE6Jyjafa0BekMzzY+2MmHR8EMVGtwVlEtEtbmTPO0kP5zja66u/Y53MKefqupxeU/KwXsDpcXWggdf+3dO+AtQaiYX5rmj+YspKdeM4O3/ksAcaYqA+zKG1ZdTSPBJ0UZV+1p+e1pHa/5dsMK7ucq2QTWqnsMvLTrDRrnZCHxIwPqRjc9hyhmp3FG87LpdEkhFlXjWfwyy0zaEHzhoKY+Pcy0iCiti/yhHYkUDnag26QLueF9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52IBIjjQ+6L0KcLPzXAok+yxZUswRt4TXhrE7fPx10s=;
 b=Z2w6/++ASEIh5O25tvdtHvGBIexmDdCON+rsGjmRDIhx2cjZD3PQSTJSdkx5F8qxssYIgnj4q/ldyxsYIIZ2CKlJvrVJ6gW02EhYL5LP8HY+ENvp3SI1mjGDuHUGK9683OjDjNWyISWXIkn+oICg5KZ3DcyKelRT1Rskyc4QKoXrDcwXa0bU0KGpY+ZH9Obz6RBG1qf/UYpIYLDXGXVmddA66sNkaLuxpv4BDpIlKLNJ3xB791HR9E34Et3IQ4PCRFEyCTeT3ymk5FEi+5jZtauQN3jvx1wXo+3A2J05TYnXsJJAoEJYWJdSgkWr7rHJdwUO1oIVvOnEzKHNmJbOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by CY4PR15MB1590.namprd15.prod.outlook.com (2603:10b6:903:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 00:36:56 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f1fc:6c73:10d4:1098]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f1fc:6c73:10d4:1098%6]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 00:36:56 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v1 0/3] Avoid typedef size mismatches in skeletons
Thread-Topic: [PATCH bpf-next v1 0/3] Avoid typedef size mismatches in
 skeletons
Thread-Index: AQHYHhZONpnVNzfg/E6gTueGNW49qQ==
Date:   Thu, 10 Feb 2022 00:36:56 +0000
Message-ID: <cover.1644453291.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5990851b-5026-4138-3ee9-08d9ec2d70df
x-ms-traffictypediagnostic: CY4PR15MB1590:EE_
x-microsoft-antispam-prvs: <CY4PR15MB159078EEFC0FABC4EAC04823C12F9@CY4PR15MB1590.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mlCyC8dyjxxQIHNjZB/mEde6wlbNbnZqk6yEExabC43VssKUmNhLofuxXKAOuGEh9xAMRPl5534I50LiN7Rde1tRamtooIhIXgAiOtYCuk3DyUEz9g/94xNEaQ1bXPQKKPH3GgwEpYcwXRntwse5KLd9TkGW41+8N3xZMI0XGNRu9apuFgoPR3xDOpU73MECmesDPzsNapwy3UkmsK89BThsQB749sVwaHlk3HIlny2nArfIRm0pPCmblZwXTvadMAJYBkg4N++4We2ZjKCnG1qSG8C0cgOX5StEG8UqOG/IUU7HZjDnb8mmDfc8kfuKCSGii99a8oY16+IaTpSyqcxt9uWjXC78BIk+8auVcQHWzaGc2P1LtjqXVbSsE6XDeZiv7cjFS3cGccsyZ7dM4QSbqS6g1J6TzMWalqRPpLWthK/oBRPVe42fHFrV2ELT2Z+bSgrOz2gexwBQqstIIaLt+DUZZJLKNPrLBsJfjq4S3jtqLLfn/ljZS08UtHx7ZMA6ajhDM/5ruvwRimquu1y/2QZO+b7lU0y+u+HhBnlc9HzsxlyUf1RUS3nctNIinXxQBC1kqKuLumvGITBwoxMNVV3lYFn/yjosLcL6DhANnvRY29rf+inZrUGOXdmZfEuqpAdwhy8+SX5RCg8KWWna1Vuvt4Fd1brt6LxCw+oYZDf0p3xtF6RJFcfiizihLsKQGAeDG3TZ3EoVUhmqU2obaihyQKt96JzWEY4Xy6/8v0d9QObZ26lWba+QPaVUv7qzLY15FuhZzMyS4P943dK1G8qHciYzy61HG3fmHi4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(316002)(8936002)(5660300002)(110136005)(2906002)(6512007)(6506007)(122000001)(508600001)(26005)(2616005)(186003)(966005)(6486002)(86362001)(76116006)(64756008)(66556008)(66476007)(66446008)(66946007)(71200400001)(8676002)(36756003)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JQobwTEEONw63WVkj+A5p9yDPFq+A2XdBwsdjVB5Vx2Yz/uOdGpMBYm2+3?=
 =?iso-8859-1?Q?lgsY38F46nyaUS6mI/6lKsccg4XMVzig9FvTQN6PDAV8INyp32t/qQDS9e?=
 =?iso-8859-1?Q?89G0QQnq+Q7gDuVrPJgR1RbkoN38fXtZkpTjvZgQkZNhqqNTsiRVq3wfWl?=
 =?iso-8859-1?Q?2RJ+tE29vBMtbl2KC4mrrH+Vm9Lm2fj80P2scz3fkkHzvaWm9hS2mxH+0F?=
 =?iso-8859-1?Q?jjItVMuKnVz0rxbb8u/th7oTigwhdikxx58CAZBfMNWJw4MBdFO0OWSZyf?=
 =?iso-8859-1?Q?to4k1LuZKAiSZTIMQRuzIF7v7tNAtYmgcNWcARH3Uqxv14Aw2ZfPu6tDQP?=
 =?iso-8859-1?Q?5mcSDzKEDBnzzdWVF1cF7/4BZyqLQHLHqFtaVZUnglUciuQeQeZdjKpNif?=
 =?iso-8859-1?Q?uyK3OzvqIRoKTxizhhooHc9gz1q+NnzRF1u6bQKiJboLAnaD79DBiFy6vR?=
 =?iso-8859-1?Q?p1ELdRNU+s0usFVOcrlhVHbNRVEKHhYPwsgYKLF9KfgCKwse88Q4B8K+oL?=
 =?iso-8859-1?Q?cF2F+SralhLrGAUrYaP2YC/2QYsqBVs+WWQ/dPbCHCwD5PcHhhaAIwMeAc?=
 =?iso-8859-1?Q?wHY99+yeppCZ23Avpq7eKl1E8XXKYfGaHaM9ZKoQ1C1VzNd3hxfsiAex8V?=
 =?iso-8859-1?Q?EAckQ7Y/qIBdV6YRA+gok60EQa0KMAITX4C0G3OW3zABudtqwLW6YeiOZ5?=
 =?iso-8859-1?Q?1x5tj1iUk1BM2vy2sobCCtEm5KYoyQaAYSKOm3BCEX4i1uxzZlbfniCKCV?=
 =?iso-8859-1?Q?u8TID05s45g74AKcgum+gulhhnh9pdxbQWfPmlJgYXNQaMDsrwL1Cgm5xZ?=
 =?iso-8859-1?Q?0r1izz6pe6rGHPG7zSydcYZYpNEE562nWfCzc0FlgQLvC4pWvEbgldUpuu?=
 =?iso-8859-1?Q?tkdDOFQc8AeBLn3EBYjwL5bqQnnbFQmww4UVe2KlxZvd1+DB2hjYC7x8se?=
 =?iso-8859-1?Q?U8pRUHySr0aIWb/GTCqfmVYVWjJMfmJVSEpj2JL/fGtjtc9fTgFzaqKk1l?=
 =?iso-8859-1?Q?v60+79JmcfIgIY2MkFcZQL6NFrW2d9dAKJSHyu/Gb6Y17u8MDGiFwSxCML?=
 =?iso-8859-1?Q?/zs03fmzEQY5mGS5jPhc1kHoS6E9VkHuUZKtsNAY7hl822rJiWe4b1Uo2W?=
 =?iso-8859-1?Q?1oTAUcKY08rbp4C/IAXPhfx/PnS8s8rhTCc9YOBbf8P0Dqt9hi9E55vV8u?=
 =?iso-8859-1?Q?z8NDFfpq3i4hYGejPxaqA58VYRe7g5fq5lypOl8GB6KQ2vo2yRCJ30snE5?=
 =?iso-8859-1?Q?mpyNwCNAq4KRVrH6NV40fl6grcyEruf7ob8xK/AXOGsR+rcSG0Ug5tv+MS?=
 =?iso-8859-1?Q?5VJbFaCdkUsI0dON01MDlW6lSeoZGsVa+7Iz5gxLLSkNWBVTXEPCuZ/uQ/?=
 =?iso-8859-1?Q?q5gNEZr5kohEwGSTVsXz2tnqFhpnsl+tsq7ZTpA9B2v/2sYtlZSekBzr/0?=
 =?iso-8859-1?Q?7idmqxQBsYXn+wJA5ibOxEo4J4aXh3KXafEctBKUCPUy1ns5APEXGmQH5b?=
 =?iso-8859-1?Q?wEIkCFWpzuveGMQqMQHi5ti1284B8Av6Sox8q/hd6TBnH3g3bt7YwaH/9Q?=
 =?iso-8859-1?Q?8E08OPlOY98i8t5wNAhQQCfiMquee1NSxosquTHQsLPaSda3n5cPhEPZWk?=
 =?iso-8859-1?Q?fN2JL6UjOqIHs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5990851b-5026-4138-3ee9-08d9ec2d70df
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 00:36:56.0373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJovIZYMwezM5Pt4qQrLvd/hJA3sI/Fn4PokTP9vFQpbeSG5e+FEQUWjop42ooeP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1590
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 8-besI_C2ZY6Go1S0NFWGrL3UpQfopj1
X-Proofpoint-ORIG-GUID: 8-besI_C2ZY6Go1S0NFWGrL3UpQfopj1
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_12,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100001
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

As reported in [0], kernel and userspace can sometimes disagree
on the definition of a typedef (in particular, the size).
This leads to trouble when userspace maps the memory of a bpf program
and reads/writes to it assuming a different memory layout.

This series resolves most int-like typedefs and rewrites them as
standard int16_t-like types. In particular, we don't touch
__u32-like types, char, and _Bool, as changing them changes cast
semantics and would break too many pre-existing programs. For example,
int8_t* is not convertible to char* because int8_t is explicitly signed.

  [0]: https://github.com/iovisor/bcc/pull/3777

Delyan Kratunov (3):
  libbpf: btf_dump can produce explicitly sized ints
  bpftool: skeleton uses explicitly sized ints
  selftests/bpf: add test case for userspace and bpf type size mismatch

 tools/bpf/bpftool/gen.c                       |  3 +
 tools/lib/bpf/btf.h                           |  4 +-
 tools/lib/bpf/btf_dump.c                      | 80 ++++++++++++++++++-
 .../selftests/bpf/prog_tests/skeleton.c       | 22 +++--
 .../selftests/bpf/progs/test_skeleton.c       |  8 ++
 5 files changed, 107 insertions(+), 10 deletions(-)

--
2.34.1=
