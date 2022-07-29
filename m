Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A417585637
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 22:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbiG2Uho (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 16:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiG2Uhm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 16:37:42 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CFC6553
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 13:37:38 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26THABt6020210
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 13:37:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id : mime-version;
 s=facebook; bh=I8bPnaT4Uc4fUHN7dTMfP7nmZdZrzfmmVTsZEkBuHqc=;
 b=lecYk2TaFeOQbv9GdaT5gOkR8nhXDCQQlHtEkTovPFGNjRO+SJ4g9bq7SDePKeYuaI8n
 pp6DqvYntY42+16mfvdTII6NgKMFIRVXzokSYcDSy37EKwTd1dHwhwSPkKsWTN1K1VN4
 WT0dneKpsIu1b0UW8bIUnwc9vTgvEDpuhLo= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hmc9e44w3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 13:37:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1MWhpFaIy2Dw9sOc4FE/D9BI/svZ+ay2vuOxBVU3KLdpW0HeTiv2nM44oi7rIHAnw1M1yYH53ASQTMdSePoFdvtaDU08Xc4EugyKqw0eStCc+MZ9X2VOxPbJtZauTg7rg7H1uhifuqyt5qUkKHfyOWF6p7pOzL2Hc0zPKKsnnHj9slfbjh+QnQoywCAfVpNd4SXZWqMCIS66D7RHvU2QH5xyiX9GKjOkBU2IfSY5/ZAvx00KVrql9fO0911r0PJ/EFrLFq5WqVs5BgiLQ05FRYJk2xAhyoXBJvhhqcvFCUnpn7NsaAZuJHfERuXl5NE2G1HfPxZfY4rUdGgrdjcQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8bPnaT4Uc4fUHN7dTMfP7nmZdZrzfmmVTsZEkBuHqc=;
 b=Y4ppLD2wdGxdh13nrX0aCvor9DRClm7ellJYIglXntt5k7UpeD842IfQviUk94ZfVGBB9XpspXKJEQSEfT6KkA/ONoLVmSjuB0DQUNqoZjIECiDzeaY60qWjB255XCSp1rIaOnb/a5hT7HrSNbt+OFT+Tp9gLZAMGEr2QmDZqD6yPTCnTFMxdXhfi6o6Y5NiT/ndwLhW81cQXquKHg82zitqCdfDX5LYsOrNiF7ZxwmlgwcGg6eTa1lz662nZgidvIh9Qzp93PqixVMSlhjBi19cZdrNoLc/Q4xaohZn02/kgO97pWWO4HTxCbFuw+VfD3kydGA1juoWxxGN8kN4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB5262.namprd15.prod.outlook.com (2603:10b6:510:14d::6)
 by BN7PR15MB2243.namprd15.prod.outlook.com (2603:10b6:406:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Fri, 29 Jul
 2022 20:37:34 +0000
Received: from PH0PR15MB5262.namprd15.prod.outlook.com
 ([fe80::487c:66da:ff78:a6fe]) by PH0PR15MB5262.namprd15.prod.outlook.com
 ([fe80::487c:66da:ff78:a6fe%8]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 20:37:34 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     bpf <bpf@vger.kernel.org>
CC:     Mykola Lysenko <mykolal@fb.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        "harshmodi@google.com" <harshmodi@google.com>,
        Kernel Team <Kernel-team@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: BPF office hours summary, July 2022
Thread-Topic: BPF office hours summary, July 2022
Thread-Index: AQHYo4sI2OGTRs2a5E2ndt+KCtktIA==
Date:   Fri, 29 Jul 2022 20:37:34 +0000
Message-ID: <E6D05AB4-6693-4081-A499-49C495C571A5@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71e645b2-00c8-4445-3afb-08da71a22adf
x-ms-traffictypediagnostic: BN7PR15MB2243:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZB8DhZiCC6W8vK5ch1jTlRduwMDX8LhAvJWWexThdYYGIcvok3UwDqrv54caShAneeOK6xosd7Cpwl9Pb3X64lNzESEZCajG91nI5biEo63V+jlVe6sXiXZJEfeXihLBXV6lu7s3fK1NOHipzBB07JS+oPqlkW1lKj3cADeJg+4NfdK/opQoI3auF2JQ87YgpPPTGeGl08stUPQKgdpGpgabmko5DpQdGgzibsXgvhtQirihEKTfNemxKV/2LFo3d1WrdV5pLa/+AxzEYtb41n5PAg/lKdxkx9vOLOfVbMzciTIvmW7hwg5pSJDPi2S1AUlx6hmuApwIt3A9X3qgm0k+JKjTxmniXdNuXpxfo8lAgLGcyVX6A7dCQg+6tYQvT0M8K8kvrogkMlaQj79Kcv34cyo4yK0AlPTRlZBFEcEL+FCjkP30g4U/rKZa6AUm6gEbELsAXgCIjrfYJTK3po7YyTBK7NI+nqmu/7zQcFbr4ejuBYGcYuG3v74S9uJsuQ3mqeVSB3taTuLeJKKBPITI2jk+8ifLh1067xaQwDtrLTelgauHK44N/yNDXc7ZJv75DgxI4Bu2O54TXDr3ar++yqXPUNo89ebZM4cjoDIac4e0UEoTUasHnVWCcLUaEEYsfhtJpoHIQz2P2oumeGNX55t85Tw2amHM5QM+CG/QPo7LrhL4sMBx71IerHzpECoxhkTRMSiotBEFdMWGTRp9T332AG6U37/T5CHvsBv7sscQ/LXE1HSuA0B90iQP5geuTUhd3iMsvmnBp6HNPNSsB79wTVID5wycv6Ae0HRQvDVR3A1H3zm/H00yo/cEiAt7qw4FDxssGy4Q+lHaEPsSAtzGvZBMfbqFSD6Pw6+sy4aZA85u8jT0K1KOFe8iMEER6vV/kv8+8/Tpbe8p8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5262.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(38070700005)(5660300002)(8936002)(122000001)(38100700002)(6506007)(6512007)(316002)(6916009)(54906003)(478600001)(71200400001)(6486002)(966005)(41300700001)(64756008)(66446008)(66556008)(76116006)(8676002)(91956017)(66946007)(83380400001)(186003)(2616005)(36756003)(66476007)(4326008)(33656002)(2906002)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A26Xd56E7hADbRM9Uj8K2jPewaLPojBNh2imCXVSpJaHsyx289ahToGEo2Ac?=
 =?us-ascii?Q?/AaFKT9ns6XOgArfk+WJJuqxZBj3AgY7aKjMbIghp6Sdvn5PKg1w2xQ2mgKo?=
 =?us-ascii?Q?ctp+wcQWaht33bHXL9omU5dLHmB5ENK4bJmYOd7K9g9vwP0gOU8zJNofV+9l?=
 =?us-ascii?Q?Z9wJk+v3hH0eoXsyHzppn+I/4/0rc5yXuP/YNgb+sFr5fFtSSYmQNLBVOHWY?=
 =?us-ascii?Q?v4ji2Ozpw6UZSsxRG4EBAA4FOPaTkOg0WqfTHQIVM4soQIVTBp64HAIQRZjh?=
 =?us-ascii?Q?dPr0Cee4VBfeb1vkURN9UlhaJeM8jJxElWVldPHrx1VLm48f5+L7lurQXt9J?=
 =?us-ascii?Q?VEZmqTRVg1Ewx/RzGcQ01c1KVBvpokWLYRTLpElVYG4JjhL6jZ2127H7aCBy?=
 =?us-ascii?Q?gcXu78Y4PDWpNJhx8YOdROpfqSMrTzhRIF2CyT9c2MZzCJI5DTB6pYt++Hro?=
 =?us-ascii?Q?o6hvbi2K2EIO6jS8J1L/4QUSO1mHtC39KZzR1L0apGzSvGrZH+cBd0vi5Vt2?=
 =?us-ascii?Q?PqmfnCO5TZ9Q4ueIGxDNE/9R9mbMlerGklUuAw61cu+ekVPvPQERVBACU+wV?=
 =?us-ascii?Q?ai08eVUZTUuztRIazK1SCwJGd6uUsLdtMk3dB6xr5Eg9tkhtS7U2RoW0rOYW?=
 =?us-ascii?Q?9/DZVmIXxjTBB57JbX8Hui0HNVW3BbPuPE5eHVLRpEdGwCYMtod+DU2fZEa3?=
 =?us-ascii?Q?2mw57cwzgAPu7D8RMo67pU5tqPAFwS6O+YrKHWqFh+lrl0r2j4tjObBdt+qb?=
 =?us-ascii?Q?oxYUO1blpzK5vAD2z+DxhVNH80Puz9TzlZZ1Iiv0GBsAth+YAyCPs21ywXYM?=
 =?us-ascii?Q?PDzWtfmeQU3tOrx0xm6xiS1dmiHcy2N+92pHtOTjAnrRu8Bx3Il3w9I/gW04?=
 =?us-ascii?Q?PgkX2zlLuduBXdC1iqV2EHtJ7mWchYwa+5rGHlYqSFuMihinuOF2uH6EgAdo?=
 =?us-ascii?Q?iZZT5SDP1awA5n2/dsu4BHL6qfXb38gGlUNRoSQyogsVLThPEwnQnMKpQ1sg?=
 =?us-ascii?Q?c7bNlTjoNmXLshgbUoWza7vchLhszu9aw1iyx0bmzJWKX/g5o4Ap4vDP4zPv?=
 =?us-ascii?Q?hEuEeIdSYCt9G0DIM1TNhq03lci6xt1qRnKIR/cnyKaxFksS/2/CmKlwEzdL?=
 =?us-ascii?Q?hjSjw0kvu6IXfGhkIq004eAYM5HH8yiiUbbEbAcx5W/IoekVkfzUNeiuGkMA?=
 =?us-ascii?Q?vFYbLq8v846Cd0QOq1MHi/Qqx20LLARphtADHB5weh53lKwMWEsNkwE/V94p?=
 =?us-ascii?Q?8vChjqvmo34BnQGkS02RLUOD1vDSxKT38QfA1Cq6K3ZzsyhO9kdxEYFlkQ33?=
 =?us-ascii?Q?KJ9IFWNNZII9GLpTulosQmEm47DXdZ+IkJkiYgshrY6NqYNNI/QoKtKtB9+8?=
 =?us-ascii?Q?twjkKP9eYfR7rnPhPwstoVi5uk2HSJ70O2Y30RVu6jAB1R075KzC6JoGaKL+?=
 =?us-ascii?Q?ndil3j1vI2faU01XILQQF5x58x800HTsYWF3jkEqaGiuV6hSpFzTcnrrSLdh?=
 =?us-ascii?Q?qXlldTqF97nP9LZVa3W5nsOu7dbrUcvSNQ6CRh8D1CXBpi6BHS8HKl9HcBy6?=
 =?us-ascii?Q?GKCFgsv1xBRH4zvVk1bpCV8Bf/Ci1ElUxFu+qXcNw2+x75x1uyvDcB2P8nKI?=
 =?us-ascii?Q?fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECCD100E6593A6498A5BDAA4284EB6E6@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5262.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e645b2-00c8-4445-3afb-08da71a22adf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 20:37:34.3598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7eQd8oBYVO2mQd4VC11z8LMupFVPAsqRCe4rI95i63rCd+f8QcoYrCr5+eH4n0FA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2243
X-Proofpoint-GUID: VBEf2unoKBOLirEBXGw45Lnp2d-_WRWu
X-Proofpoint-ORIG-GUID: VBEf2unoKBOLirEBXGw45Lnp2d-_WRWu
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_19,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

Below you can find short summary of BPF office hours that happened in July 2022. Hope it will be useful for people that were not able to attend.

I will try to take more detailed notes over August. Let me know if you have any feedback on how to improve these.

Thanks,
Mykola


7/7 with Eduard Zingerman (eddyz87@gmail.com):

Eduard proposed improvements to verifier.c:do_misc_fixups() function that might exhibit O(n^2) complexity for certain inputs. He did benchmarks on the selftests/bpf inputs. Agreement was that we need to do benchmarks on the Cilium production code. Daniel Borkmann will work with Eduard to provide him with object files to benchmark on.

Eduard investigated on three alternative approaches:
- a previously suggested by Jiong Wang [1] approach using BPF program representation as a linked list of instructions
- possible representations of BPF programs as control flow graph using basic blocks proposed by Alexei [2]
- a novel approach with patches accumulation and application at the end of the transformation passes proposed by Eduard

Consensus was to implement a prototype based on a basic blocks approach as it is simpler and already used in LLVM, GCC, Cranelift and QBE.

[1] https://lore.kernel.org/bpf/CAEf4BzYDAVUgajz4=dRTu5xQDddp5pi2s=T1BdFmRLZjOwGypQ@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20220624183918.qatsud6fdrtjj3qy@MacBook-Pro-3.local/

7/14 with Harsh Modi (harshmodi@google.com):

Harsh works on adding crc32 support to checksum sctp packets. This functionality will be integrated with Cilium. This is needed for a telecommunication project he works on in Google. His current patch was only tested on a raw string and will require rework. Alexei asked a lot of pointed questions and suggested Harsh to work closer with Daniel Borkmann. Joanne suggested implementing a generic hash function and using dyn ptrs instead of static pointers. Harsh admitted that he did not know about dyn ptrs and will investigate. After the discussion, Harsh agreed to implement a generic hashing helper as a prototype, measure performance and send it to the bpf mailing list.

