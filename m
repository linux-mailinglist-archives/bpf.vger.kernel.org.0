Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37247502E11
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343758AbiDOQ7g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 12:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiDOQ7f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 12:59:35 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2631D673CC;
        Fri, 15 Apr 2022 09:57:06 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23ENtfij014529;
        Fri, 15 Apr 2022 09:57:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=+Id3fg7K6No6KzWi+SP2czJhyQuQFmJ+5rihwF1Jn1Q=;
 b=Vmj4pnfwr9AG3D/3cW52zUHObfpl0mrUZjLDMXJyFAUpyw7mGN0wadHDUoPU+snSyao9
 DnkKcwQMNR3dK2qPExAzl5b5cajldrN6WyGvChT9iR9kNJ7XypgoHjTnCgNyrp/2qKkS
 OMwZiY3iRMwZY9rbNvm4irGfZTXVYMK9C7M= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fewgtkxu5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 09:57:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0BFU70FUupkQ0xAFamns1N5DBtilY356CAEjLgOwS8+lSjQgIN+m9bnIopTihiT4FQ6jQvNKAqVu5tODVdF2bNvrXLQF+kCfLdk0Y/J/Wt6Pvf5LKhz5Gu7PxVt66qzT1He4eL1TNKx6h/yQ8lxktWt8FHWsgy0+x3bY49vT3Nd5yM4M/fDZhaxNNnhfZKbvQV3zsEn8s13mLGBScNI5fI5x6V4bj/+UEM2+s9iN2vMH6Vf5W+nwifM/DAgeZNWXGEGBz0S/ox8p9wCV+1lN1F7EgFP36oZKZh7MPrP9ZMSsisuL6i04DmkC2B1XgP5Hm5Rdr6fpzy37+iF2GWE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Id3fg7K6No6KzWi+SP2czJhyQuQFmJ+5rihwF1Jn1Q=;
 b=oPCO4J3XFbzFmInKizv/bP7+zGLGpktJfi96N+waHX7ao1rH2oHSDpD1YgRu/7TZ6q9FK6qMeg9t/i1dAvqWI1Abt3V6ZMNIHFzxNnEg1FNvzzDScHDs+7aGwQhzDmY12arzY7ojchbSmvQSMxQA0s4M3JPaHkTLP1r6T2Toe6q5OcVYeE6LT2ZQHK7u8B3rRQIaHuNonsd9hoxZ5VWaeGVHWhHZE3qYcqNzpz0oxFRtFlw8BbYBqaQaiqwVY0O7fG/YtRQ/zqXGw/oEQ24wB2Zto+CNHBGiy2mcVl6nAUS7WXfSA6mghJQzPQX/P67qQ2oo8nDgR/jaEmSuZ1onuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BN8PR15MB2611.namprd15.prod.outlook.com (2603:10b6:408:d0::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 16:57:01 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b%6]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 16:57:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH v3 bpf RESEND 2/4] page_alloc: use __vmalloc_huge for
 large system hash
Thread-Topic: [PATCH v3 bpf RESEND 2/4] page_alloc: use __vmalloc_huge for
 large system hash
Thread-Index: AQHYUDrlxYc30IXNyUOaichBN4uohazwhJOAgACunYA=
Date:   Fri, 15 Apr 2022 16:57:01 +0000
Message-ID: <030EA68F-EAA1-41C8-B7FA-0675B118F0D8@fb.com>
References: <20220414195914.1648345-1-song@kernel.org>
 <20220414195914.1648345-3-song@kernel.org> <YlkRY8QfAdNk+Oso@infradead.org>
In-Reply-To: <YlkRY8QfAdNk+Oso@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d3f1e62-c637-4391-2cab-08da1f00f641
x-ms-traffictypediagnostic: BN8PR15MB2611:EE_
x-microsoft-antispam-prvs: <BN8PR15MB2611EFA275886FD44F0B65E9B3EE9@BN8PR15MB2611.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hUqdJFsJH9bSIo1gwrI9vDdYwcgeJYVN7iZdAw/iA+3Phf48v3g71yQinQFfqeVG33Ef9SQqKXcAt/4ufSOctNPndgsQqoMVpgbkk7lLISFg15pmIrjdRrq2JgTNxu+jsWHtW8MZDUy9FkqcyKRLrqsg8F1paWK4Pps1BK205brbIp6D8TCZ/Z6JSUiR10nCP32XW3ya3at0ljd3Gj5p8i5/aTXLfhpi/DwP8jHcIX53b86bcJEeYL0jKbm4PbGUKCAfOs+NDpe3yhAJEa9mKGG8He7ybJd/eEVAxUylIoZBmMGcbgopKnyMvbddWamPe0g37Mb7htFfWLt6xjj1PN24GfwCmlbpioksUHeMJACfWtsLN5e3YD7XIDmcjgRbzUyHS5jMekwYCv6tKG+JQuSIE/e95hbL781G0DSlpHAf9w8T/6go6hqvsED8AdYWMrD390zLTYxjRMoaADekhV55oBFYjnCQLuCrtU6IJF3wPSrzKXBUP8iIoyXO7Wp98ddyUzC9DIr+VQ6OyE2mm+PNUUTJLdp8LBIXys1fVIAEzwqrM7J2rGIJtAy0JlMNcCVXv/q5chD/vtvveB5smAwN6X0Nj43SmWTPQBIZ4jx42HhxmWgwnelm1bc49e2sFQ6BdC2Pu9RrQMwyYWRFDfmQjMIIcWafinvA5PdbA5NZNEp7AxxdpQxW/ZDRe2HMgUACqyVEIw96AfV0CnzB7wiG9JXTjzhmyvEBDq6f8LPQSPTGMZXyYd+ORz280PHTGsMyKx+vxzsNF+nQj+2KJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66556008)(66476007)(66946007)(38100700002)(66446008)(64756008)(5660300002)(8936002)(4326008)(6512007)(86362001)(2616005)(38070700005)(508600001)(122000001)(6486002)(7416002)(6506007)(186003)(76116006)(4744005)(33656002)(2906002)(36756003)(6916009)(316002)(54906003)(91956017)(71200400001)(53546011)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UJJHjxaG7VWIYrUrXesGe0cZgFz6xwHBLcKd2mZOqwUNHfogCwgN/g812Ftb?=
 =?us-ascii?Q?mBbv+v6DyLUoYX6PVhB3hsmvR5yruotilM+6dHpDr4pRfNauxRg5Akp01pQi?=
 =?us-ascii?Q?7v9U3QEecSXiDwctf3UiUtCWO4fZRxuP6ZQFerRj/EM9HYfyugUAvtvdo2EU?=
 =?us-ascii?Q?aw6fsHmuJoBy+Qeb0Eesk/MSQeOApjGRl//ZdATNGO0oQc6Ab9GhAh3aFNtu?=
 =?us-ascii?Q?yoaJ3Gs0uIosWFYnq/IcS8/7tpQjzKnXHN10lAghrCzCmJk9gyeMQGvvJ/gl?=
 =?us-ascii?Q?NmWML9Au4E8NrV5QQgBZ/HRowjlGv/9pMp5v5uN1klLF1OQ0K7rxmwY4j8ss?=
 =?us-ascii?Q?KYJ52Ulp64fkrU17aSHHjq6hEah6vwYwR1F4NzS38S5CXtxnQ+YqWo9MSXFs?=
 =?us-ascii?Q?IMfblKO6mKPgRz1W1wc+Dau5jpJiKjUPHzGsOsOGXl6okTnKe0ekaz/S6TUu?=
 =?us-ascii?Q?i+pX0wRR8XgZb/WCMm4rrugpHUkj8iV7gkoVjUCId2/szA5FjcfJcKpFiB7M?=
 =?us-ascii?Q?DRo5zVqwLudgk4FjU+AcOJppEEhx2t5AhRWlR3AFcZw7PFnbuC7eR1nz7y+O?=
 =?us-ascii?Q?J4hxUPljayJYMhH28VUXvw76L9ry/66IsMBnX8I7h9CjT5I95FJBvzKQmphy?=
 =?us-ascii?Q?yzyI1lQhLnT7WMgPl3SShJ5riJ2yjPap+Rd89ZFIaYCBj1tEi8Z4yZOi9wzF?=
 =?us-ascii?Q?03ccL+wbruH0Sdbsyzw1hgT45P7FoG+qd++PC/KgEihZhFTpruBryTQZmA44?=
 =?us-ascii?Q?2eRqKmK001qb4nMiDgC5RQ6tqbSDyVQCtSFhisbWk9YlHqm9HCfWEZ3Pl3wE?=
 =?us-ascii?Q?LzzLXZZAHEk+Dp1Fk6Q84iMVdrM8JSb50phJyTzrdQkR4UcgUhc4wgEqwK8V?=
 =?us-ascii?Q?bUIOfxKSCUElxkNLVhvUZwAl4+SlCEhdKhqyGkVdfNPk9y0FTgalN8ejzpSR?=
 =?us-ascii?Q?IdULXJelPjcJ+B0Z0CqHOEXEQHyXfQnTENugUWAVfYOH/UO6szFMmsNkrk9W?=
 =?us-ascii?Q?+FsD+MjQGUBUzagRc1MdR52s6IDfYMN8hInt+yAxm+nTFivAhKQKgKmBPwd2?=
 =?us-ascii?Q?qz8f0XF1VrgavV4p8J7ppDIr6zb3cXCZ91Hlho22JzsvjDEnki25h7M+Qluj?=
 =?us-ascii?Q?LrvtPf5pts5hFG8Ql1okwhCIOzzaJl9wyRisecNZhoj2mwT4Ka/RQ7G1aC/l?=
 =?us-ascii?Q?xZEZbpiTTdAIvMODi0Trw5pBw34bA87NP+kwInqdySugdbvELzRuNwTBbceN?=
 =?us-ascii?Q?SBZx8zD0URFj6At4fK/eyM7ALLwguSwLVeZO4B34snlVvWy66qhdxqwqQuWm?=
 =?us-ascii?Q?5w0jX82AlODtxRoFHAtwuBF3ji6d4vtLBPe1hj9Sc4x2XMR3DYb9e8F7xgxo?=
 =?us-ascii?Q?dhAFIRSBXwIfVjxDf0hjloiJ4JRM9D5XdLjcGAm42/+Ic3X0GAjem83vtPx6?=
 =?us-ascii?Q?SeoGfZ/6h+r0t1r4n5qHKR9BB8m4whxpup0qQB+P8VUwkIiw8W/rqwYyB6Z0?=
 =?us-ascii?Q?kZBjH3JPMquunvolW9HyWGmvurfqFzfZTjZlkJvZO4HxK+RVogOIElg+AAqE?=
 =?us-ascii?Q?1q3KmUim7PhvSTwaAa4uzCxyMTXT/dN+CJzkwDAm1lkOOqXs4ci8YkOpoXMi?=
 =?us-ascii?Q?0uRu8WBx1ViraY/YCdqTtv3c3jm8ji3gxnf7kIcQZDySFwInAmIfMEBe1LzF?=
 =?us-ascii?Q?JVURYvavSkii1vKTX5epmP47ReHdKyCIT4z0UujqkhMXUn3YCcmfz3JKPB10?=
 =?us-ascii?Q?N5lJAkJy7u5PZOcrvfNt8+1tVu8wLOOe0pmxh3rpJGRTJ/zKmlCA?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B74B831D96FE44BB9A6024A80D9483E@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3f1e62-c637-4391-2cab-08da1f00f641
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 16:57:01.7649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kD3eXzK7rsNd3zudgOugM0iF5EdeQ/dLCoeF79PSe99xQ4lEcArGTCbe8I5jKQprOu6+ylZFHMNbmCQCA1f1aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2611
X-Proofpoint-GUID: nEhi7f5CrCqmMpzFh4X15AP13MDF91hM
X-Proofpoint-ORIG-GUID: nEhi7f5CrCqmMpzFh4X15AP13MDF91hM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-15_06,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Christoph, 

> On Apr 14, 2022, at 11:32 PM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Thu, Apr 14, 2022 at 12:59:12PM -0700, Song Liu wrote:
>> Use __vmalloc_huge() in alloc_large_system_hash() so that large system
>> hash (>= PMD_SIZE) could benefit from huge pages. Note that __vmalloc_huge
>> only allocates huge pages for systems with HAVE_ARCH_HUGE_VMALLOC.
> 
> Looks good (modulo the possible naming chane suggested in patch 1):
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for your kind review!

Could you please share your thoughts on shipping the set with 5.18 (or 
whether we should postpone it)? 

AFAICT, the only changed behavior is to allow alloc_large_system_hash
return huge pages for size > PMD_SIZE on x86_64. I think this is 
relatively safe, as this is only for large hash and we are at rc2. 

Thanks,
Song

