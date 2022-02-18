Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877874BAE99
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 01:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiBRAg6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 19:36:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiBRAg4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 19:36:56 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACCE15A34
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 16:36:40 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21HMl0G8007895;
        Thu, 17 Feb 2022 16:36:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : to :
 from : subject : content-type : content-transfer-encoding : mime-version;
 s=facebook; bh=jdMO0gRrrNwVvq/wwtBsHGjdH+46/xBJ1hIrgRG3H3w=;
 b=CC5bPrXzHhLdklbPUw/LuUbL3EpGGdvLI/l/c9e9k1uGhAhycTzt9pQ21D8xCNodWzY+
 j6WAAAioAVxi8wXtKwxg0FdZeRuBsALopxZekEVGOiNPl7FZMS0hJpopiyDHyaXk+hAB
 Jy8EYkRDP246pBqAhm7ZVlKQTFC8hSOq3T0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e9yf2rht5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Feb 2022 16:36:26 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 16:36:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvOidUkYWmrOUc6T2PccCavzU2vliki2IQAlT8abvU0AzioCxM4JmVkm/DH6cJQ7ppgqMAw76UOVHwQ3iQDrhx7I5tIsC9oLfnEhJY32YshhmxY8A/DL0sEw7zsR4iGPqya1f1SZId4JCr+NFHg1a0ztGvkprDjxrjaxTzM81FvnKL85h0XPuwvlL62RGbLRq5kFhP+qi4YRHSNbDv4gxm9YwrFdbyGJXT+EKoMR3otF68J+qrQurqxGLxye7ZnMd/gAjj4gqkd34hWSf3Vgdlnb4P7v725VwSEGsfKE8jaeaw1UVSFNxl/p/RrTzNJv3x1c56d6O8ahmaq0xpb44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdMO0gRrrNwVvq/wwtBsHGjdH+46/xBJ1hIrgRG3H3w=;
 b=bqDiPPfHFLVmBk6QAAA+yfne77BNpqGU7JGxBuhg8xQrB/7E7Godvo9MTRj0VHbRGonpz0+pEyAAOkZXidVr0Fp88xNN4aqGHKQdJqVCo/aBeFYjKW6GlqCE03MV93s4FS2mpUQ96MvUkaj5ma107wi8jDyAUMKoiFON0NojHtRoWPU8yPCM1d+Irzd8Za3KLIP6jdMZnZd6hgEUFdy+5eDKwqC7mrFk/6bt09lHkbxBTIuG1CwNm3vTSYahucqcpbq/AWUSjkI/k6SkYrtpYcL1bBPBCXzxNTifLT1UuyOzHA9EuvMjb6XwqT6qW58YYRHHp8f1lKhJx6dAyc4Fmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by MW3PR15MB3946.namprd15.prod.outlook.com (2603:10b6:303:4c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 18 Feb
 2022 00:36:23 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::f87c:9255:4531:117d]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::f87c:9255:4531:117d%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 00:36:23 +0000
Message-ID: <4260958f-daf2-5399-c0db-9ccec39461ad@fb.com>
Date:   Thu, 17 Feb 2022 16:36:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Content-Language: en-US
To:     <lsf-pc@lists.linux-foundation.org>, <bpf@vger.kernel.org>,
        <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        <daniel@iogearbox.net>
From:   Joanne Koong <joannekoong@fb.com>
Subject: [LSF/MM/BPF TOPIC] BPF dynamic pointers
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::37) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba0a2998-06b1-4439-e12f-08d9f276b06e
X-MS-TrafficTypeDiagnostic: MW3PR15MB3946:EE_
X-Microsoft-Antispam-PRVS: <MW3PR15MB3946FD3C8091D10302C0C14BD2379@MW3PR15MB3946.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aH+Iq7nZkXOscWTHatADBc3dXK0OqEIPX9It/LOs1KAFC+WNgO4vArnIY23rry8UmhPb2+f5jOnoQ8tuXkL8HohaUokQufxylXhbGTOtlidTW9urV7eOT41227jGBcN5GrZ3rfQvZGI21gnw6bhSvve6vvv0G+rbn15KOpE3PyN/XHoI1NaNn6Yh6Ey46Y9d2vWe2fEXJOlDqiTwawVDrZpuJow6EZce2ANmKdm/YcxnpsVUV87urASPXXLAuPFgF5Lxfzx8eghdbU7SPQsb3sXGbD9NoYlnvucPbxnROoTIrV9HmUzW+1vsXKTsXWAQOcqxDuO8aKyEtWtPFFOEfDIjXkWyl+r0fQFuX/tEDpttCsiQOQnNZJIwigV1DRpsTXk5H6pBClB121w+8NplqvBTylJor5B8gsp4/XPH8+QUNSoOw4WLv0bEWnCPfTSCJLX/PVatV5bTFAhcwlMaAdvpg9E2oH/9J5DoL+kGgYGER+wMY+OEw65/lmTWLWIHxgFXYrmtvM84tOTEkoH3dsgpmSwUIW3/NHSe0krcnF9iHsgGP8nIJMcvksEY3tVGnNZfmuqDKrpcYr0/oKIcp4E2cl37VUPkdi2DMUVQT+ZYomCxBfwmmqMnabz7T0aqCfWTDE8mdk6VMk9WR1JZGMnXQ84n0cdwfguixjQ15AWfO+Z3qUY3wKbRz/TC7a7BTZKE4RSMRbdABPa6qYvwIqO2+P6wDFEIrpIzhtZHBTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(2616005)(66476007)(5660300002)(66556008)(66946007)(8676002)(83380400001)(6666004)(8936002)(6512007)(316002)(38100700002)(508600001)(2906002)(31686004)(36756003)(186003)(6486002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGthUDB6cmxaQ2FlQkxtUWNqRlIwSzcyd0M4QTU5clVEemxTUkhmYTlTV2o2?=
 =?utf-8?B?bGs2dk9ISzNPekhLTitVaVRHMmtBa0ZQcWhsdGRNbng1MGZqTW1CVEdJZGVW?=
 =?utf-8?B?MDd5TmUvQmsvQUlyTXpDYUthWE5ENnJVL0JJY2Q5YklUWkVzUndib2llMkFB?=
 =?utf-8?B?bWNJVDRYb0U4aFNGRUphNyswVHdLaDdKMEdnd1MxaG5naUJud3Brb3dKWVVC?=
 =?utf-8?B?ejR2SnU4T3ZxKy81RjE1cTVjcis0OWE2azBIbTVHcy9YZExmQkFxbHhGQzlG?=
 =?utf-8?B?TndDK3ltbUpCU05ybGlQaDIzQ0M0MmlKVWg1ZWVMWW1jSmhqVUk5WGljSUVO?=
 =?utf-8?B?eFBTdGdhQ25pZjNEOVpLUEhzU0lGdmJwT2lkQjhsNTZXamthWldUaW5EcHFC?=
 =?utf-8?B?SGFYZ3h2aElQT2RtOVM0YmxKYXJyQXRmWjhTbFlyV2RCdmNmU3lxVFNzUFow?=
 =?utf-8?B?WDZSbC9SWlloUjNkd0MxMG92emwzcVJJYldBcy9CeE5JdDNSOEl5cy9WeTBJ?=
 =?utf-8?B?blV4WW5SY3JWcUVuTUhWSEJpQ1lQVGhKUkZ2SUw4R0lKdUNDYUpCZ1p5K2FI?=
 =?utf-8?B?S045NVlsU3dGR1ZnRFJoRjNQb0xwUjBCZW9ISjVUU2ZZbEx6aGN3bkR2WW1n?=
 =?utf-8?B?RitobDlqdG9XNGJuZEhBS0NoaCtqK1VnclAyV3dPK2RvMkpVdE85dXRrSDVn?=
 =?utf-8?B?Z21ucHBJMG45OUZNWFFlUUNWaTAvTEhYdWk4SCt0WGdhUWJjS2RKSDEzL0VJ?=
 =?utf-8?B?b2RMUVF5Z0t1TWwvWHdTV0JaV1FRNklycmR3UkpTMmhFajFjYUxaa3lLRXc2?=
 =?utf-8?B?V0dSbU1yc0ViUHFWNkQybWZrUmdXZWVOSzkrc1J1QW1WcSt2MjFXOU5kTlVQ?=
 =?utf-8?B?cTJvVHVUbi9DZVdDdU8rZC8xWkdudUlBamQwU1RDeXUwVVhaZHhCWWV0UTNw?=
 =?utf-8?B?UE5Jd3FqN0swSHZncUtJdVNzQUFrMnJFSVg1S0c0UnlOSE85U3hKdEJxZllN?=
 =?utf-8?B?MkxaRFY3TG9Hd3o0S01nWWZldzBldHdiZGpvSkViaENPQTlWNXpQZnI1WUd0?=
 =?utf-8?B?eXpQMjhIV1hNRk9nZWFtNWlBTU9OVnZJM3hMNDE1VEtkTFBRbTlKaU9LWUY2?=
 =?utf-8?B?aUc5ek1KdExOdFp3ZnZUK2czR25uMlBOTXcvN2pYRDJQZ1FTNnVnei9MRmd2?=
 =?utf-8?B?WThldnRNZzJpTVo2NEVTQVNOV2w4eE1ScDZOUzF6MHVBQmtKbEx0L2lxZEJs?=
 =?utf-8?B?bnUzRnNmTFlVSWpacmhSY2xyRHZxTkpScFkrWWxtSVl5WWN4a0hNQTBOaUc2?=
 =?utf-8?B?QUJ2ZU1VLzZCM1ZreFN1dEk1U2phU1ppRHpQNTUrQjhFZnptcjBCajBmaFFK?=
 =?utf-8?B?MXNRR2RUY3VNd0p1RElYNVF2MDh6SkkzVGRoTjV2M1RTc0hoT21iOEYvVS9j?=
 =?utf-8?B?bEtkeFo5VWVYOFBNSzVlbm9ldGJQZmVqaWoyVjVSMjN6QmdUckJ3QWUxWi9E?=
 =?utf-8?B?RXZJblEwaE1FcWtUUDdPOWlYVnhBdFBiMHlhNStaK3lSMjNyTTlnVE1pSi8y?=
 =?utf-8?B?ZUlEUTBIMnB1QlYvT01Ic3JPQWdXSElJcklGdFh4Nll2NmVDU2RheHVPazdp?=
 =?utf-8?B?T2hydXQyRTVqM0JZVzNLQ29CMlJhM1R4WlVMU0xPOUgzVGNON1lvMklLSjlN?=
 =?utf-8?B?aWRyT2NiWGx1N3d1Qk1mdFVqZm1NQmZQeUx2OEJMSExvS0YxVmNJOFkwYzFX?=
 =?utf-8?B?RlVlK01rNElBL2NoeG82ajRxNUxnakxNbGVSZ0c1RFVnOVVXb0UvdDdqZyt2?=
 =?utf-8?B?aDRlTXB5VS9IYjUwcFB3NkdhdWxvclI5emNZc2lWNDFIQ3c1ZTF4dGhtS0tB?=
 =?utf-8?B?Uy83VVMwclBhUkRleExUa21malFxZjg1ZDVHM3NSSGpKblNNWWxhWFFEWms1?=
 =?utf-8?B?SkdiaHFSVG8yTzRJMFZScTVyT2xYS1J2RExuVkR1OHArUkZWS0tnYXlqZ0hj?=
 =?utf-8?B?b3RSVXRENlVIMkRzWG9hamduQTU1MjZxZmpnVHF3eU1qMUNscGJ1SjBDWlg1?=
 =?utf-8?B?d1J0MGZyWU45ZWEzVmJXRnRNYmh0TFN6Rk5hV0NqcDhOZ1hjdGRxTzRNbUVz?=
 =?utf-8?B?VUNGSCtJcjRydDVYUDROMnpjaGtlVlA3ZnI3d2pHUnk5S0xkbnJybjd2aC9l?=
 =?utf-8?Q?I8hJLyYN3Jj151Qo7pvHcRAa+CSMo7jqwkGS9q7+ez7o?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0a2998-06b1-4439-e12f-08d9f276b06e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 00:36:23.0692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQAjHKzUF3XD+R6Qx0DGVg6hAUjBpCqHpXDcmnK5XALu+dffjeCq9xahl3L73+IEfv3XPDbn/eo9+fxTwe5obA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3946
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: hXHB9s-pGJnV8dR-Ugblb5e6c3Yg2NoM
X-Proofpoint-ORIG-GUID: hXHB9s-pGJnV8dR-Ugblb5e6c3Yg2NoM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_09,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=783 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180001
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

*

Hi all,

**

I’d like to discuss supporting dynamic pointers (“bpf_dynptr”) in bpf. A 
dynamic pointer is a pointer that embeds extra metadata alongside the 
address - this abstraction will allow bpf programs to interact with 
memory dynamically in a safe way. The verifier and bpf helper functions 
can use the metadata stored in the dynamic pointer to enforce safety 
guarantees.


Some useful applications of dynamic pointers include


* Dynamically-sized ringbuf reservations

Currently, our only way of writing dynamically-sized data into a ring 
buffer is through bpf_ringbuf_output, but this incurs an extra memcpy 
cost. bpf_ringbuf_reserve + bpf_ringbuf_commit avoids this extra memcpy, 
but it can only safely support reservation sizes that are 
statically-known since the verifier cannot guarantee that the bpf 
program won’t access memory outside the reserved space. bpf_dynptrs will 
enable dynamically-sized ring buffer reservations without the extra memcpy.



* Dynamic memory allocations


Bpf programs currently do not support dynamic memory allocations, but 
with the dynptr abstraction, the verifier can enforce that any memory 
dynamically allocated will always be freed. One useful extension of this 
is persisting dynamic memory allocations in a map to share between programs.



* Dynamically parsing packet data


Currently when we parse network packet data (eg xdp_md->data, 
sk_buff->data) in a bpf program, there are two main inconveniences:

 1.

      We can only iterate through the packet data in statically-known sizes

 2.

      The verifier requires manual checks in the bpf program code to
    ensure we are not accessing any memory beyond the end of the packet
    data. Some of these checks can be broken by clang when it does
    clever optimizations.


The bpf_dynptr abstraction handles both these cases. By embedding the 
packet data behind a bpf_dynptr, the helper functions used to read/write 
to the data* can check that no memory violations occur.*

*
