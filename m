Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8F587F91
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 17:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiHBP5x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 11:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbiHBP5t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 11:57:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F83330B
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 08:57:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272FFeRN002880;
        Tue, 2 Aug 2022 15:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=kQqzjMrmGr6vEYhfojapReJJUp5FNSQaexrVYEagiXo=;
 b=YePAMDkDbECU0b+Z+I1TEF/rIIp1JnaXhjrOniK5XStemHMJ6Y9kOrglSUc8at8vuBcG
 yC72JOdstQug2gr6usJCoErVyw0R39qjhoJuV6xiCin8KeHmHbdpEmF13aGI93qZkgKh
 Daur6qZfE69Vm5OOlfCorIebM9LA2htrGwdwnAIJol6KJQ+J7wAdMnp3r1/r8gL//eST
 oJw9/aP8KQvJCDy6POGL6yJAr++H9gdSSGayQci+zWlwAblLhn8hBfkps68TmsUr7+4J
 H+nAi/zRgDlF7SCt39TKkP8bjOdwgjiPf0GdubcQSwCfaSiN1MEe/2DM9d/DZUWyT9am xw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80y8uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 15:57:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 272FYLxh010948;
        Tue, 2 Aug 2022 15:57:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu32cygp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 15:57:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSJfq8vkS2nkfIlWZrGXOCPXp6eX4YsgWijFWWdWW+pWUxqv40+E6BATVHVJg2MIfCxq9PqadKuxNyT2K5dSnNhD+HTzaCclmXXSqhK5N3YhRX2xpF32aj3nmSgz+TzQVkvHu+DKBveuDEjwCb5KoQcTslI/6WBV6yGXU8bjjtKHSXS0QarfWihPpB6e8OV+CnKt+rbPAqpgpJb1BXenbnRJJI2NBgI574PdMaozsBKbOzIqUW0ZxqS6YymngdRHGVqFIhkevWnsPHHEklCdBPqfWxAfsXswBMgA+NfoXHUv7kFFfpRHJ75lgBM5/6vmyQ3DCGpJcUrU39dCPfIHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQqzjMrmGr6vEYhfojapReJJUp5FNSQaexrVYEagiXo=;
 b=nJWbPbdvB0xNQUYEELOn9yIPvsS0zHZtxw5LJMGoO8gOBynOTluITVFjlL5LlT9LRLU4VmiM1eDbDygZQ5/FvDpLUrvtNPzB/JIeEVo0v5vQ5Ta8ab2XmJvBR+k4H5Arjn6bjABHLZjfcoe4fC63Pia8tKYhHJ6+36DzXUY5MuepnNZrXP2k2dt60k9AlUe/Fg8tJR0Z4DG6le7Ec7oKQpEjOw01/Th68a3X68hg9KXxfl3LeyCxasWblN8tf/T56hqE7GG/Ee/sAZrW/Wauid0YQMuv/1/QZozD0JYjjbo7CO34dLkYT8m0xuT08i5ysM9hQEMs0f90cJcYyag98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQqzjMrmGr6vEYhfojapReJJUp5FNSQaexrVYEagiXo=;
 b=CcDSZI8utsq+sOfcq9Ey4XCyzjytzUdAaWe868rSRqIPyQjtI7zzVYwQojYREwYfcrhneZPa/LWGQE2gtXkqBMmbaS2fv8ZtougiCNMV2J8vt7JEa0FNF97vqMpPOUzKCC3OVVrhDhEy29sDKQJt3ptyln2EocD+ITjLw8sBDIY=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BN6PR1001MB2227.namprd10.prod.outlook.com (2603:10b6:405:2f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 15:57:44 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::b5ee:262a:b151:2fdd]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::b5ee:262a:b151:2fdd%4]) with mapi id 15.20.5458.024; Tue, 2 Aug 2022
 15:57:44 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>, david.faust@oracle.com
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
        <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
        <87wncnd5dd.fsf@oracle.com> <8735fbcv3x.fsf@oracle.com>
Date:   Tue, 02 Aug 2022 17:57:36 +0200
In-Reply-To: <8735fbcv3x.fsf@oracle.com> (Jose E. Marchesi's message of "Fri,
        08 Jul 2022 20:33:38 +0200")
Message-ID: <874jyubpu7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0348.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::11) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bfb4a27-8c4c-472c-7254-08da749fbc96
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2227:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuVmBwZZPDzzjJrsvSLlKNHHoHyCMX/yAaA2UH2Sql+jpUWSfbl330aN3ZD2b/hfPNcBWQh0TgjCpmKBNhNFkcAzdPaZEz1CR5eP9TdvcF7AHD9jt3BJ87QNmSAvWXTiBCgmAagtQhZAZSBfguO16hoAw2UtHz2jnQYuOLQnKmZeIVQti8dvSHRG6yaEghxTf9i80S7NrSzn0RBXoYFyizwzPU7ukOXHU5bZcEHwD6my2XDgR8hC9lXyTSBzPjfwUZ+K2R/TDoluzztqE7khnkLP0YMCTT5bPXeLE5P/eJZ2Aw77yEhW6tbRuFmN44BirraPp9YM7LCUO4M0boSnJ702W4aGNqGY6Gq65fPnSZuQCaeMa7sjfnz+RYxHtAUaJ03TalQ4r6iadgqeFBinZLHyAp2ivTChV2ZEj7uhsYXq8Ek92V4kTeAnL5UEbImwerBH8Mh4z3F4kThxz0vUtj261zKlNapVihDwodORqfgv1n+W3NmdwQzsRMmKN9aLTrznoZjiHvKE6PTfl0WZ5Cja8IlognHipm73Evu/DHNxYu8kWWfCHyCL30kzxAEfTLkjqDDR15+32U8m/kSMWVaMEBU2TVKaX7gRjQjwZTu9Uj5zCxDh3sIl8OT6MHavDRUoqrN4zRxoEIXaddB2NvsQyDL9ewYjy/wmKgywwrHUjU10KLOaYzq8RsfLz2FnYpVaRUj9b4D2IRaGLMR7dGJdzauYip8OGHqEuEua3E+N3ztMviZIbOKasEAufLB54c3JOAVWFlShpmSSWZxiY4JtznEaUJ7sBTm6NUnxnXn4QPu3HJyl7DJdscxweyfGOwVSpjnwz6znH09R1y60zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(136003)(376002)(346002)(6512007)(6506007)(26005)(52116002)(186003)(107886003)(2616005)(38100700002)(38350700002)(86362001)(6666004)(8936002)(54906003)(6916009)(316002)(36756003)(2906002)(8676002)(4326008)(66946007)(66556008)(66476007)(6486002)(478600001)(966005)(5660300002)(4744005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e4BFcD5iQg1l4wbnTWQXHR3r2ZjNjiE96FUFG8pMYK7LECKf7WMAOHj66o5F?=
 =?us-ascii?Q?ZUHPDYQHEas8BYCI7mtkMmr3jc0Qu+pPi4LyeiIokNsXgf6brZBkzevCo6B1?=
 =?us-ascii?Q?7VNg3+eJUI8WLhynL3RPmiR+JZLt1G/mO3en1hw+rWDorKLE+S8me6gzIcwA?=
 =?us-ascii?Q?iTdybmFI7x9dI2avwmGw4Ig6TgydgKiG0sjHLZ1ZRXq457nWrwn8aUsIRD5G?=
 =?us-ascii?Q?YXl77jEZbUxUmmABB9eFfMIOgfeT9m3l2D8jl0vnDVnemjqnzVTf2xn1QHOw?=
 =?us-ascii?Q?51BfV3Epo3twzxrRJvoNdDHSsuac3rLhQsh/W3Snzi/y0L/LoNkl9F/Yl6r2?=
 =?us-ascii?Q?kmL9pWzkU37qpr1K2R6AxtRMZpc3EfVak649Lch8OR3DQojbzxbi1b9Ntr3z?=
 =?us-ascii?Q?VnWCRzRiw2rCbNan199w7JXe5pkUU9NTgunduSe4APyCwu2WUhLzOq7zlYKB?=
 =?us-ascii?Q?F/N2gnwW3KK0XC3eLJRGDcHVnPISGJa1M3HkUDOmRnc7eoPK+VcESvXaTGP4?=
 =?us-ascii?Q?XOB+HTKc2rblBYZUNqUiALGzBlFmrXSisBsFg3QiNlmXp26d4jaXJTX6YRdo?=
 =?us-ascii?Q?AbpJ0qkgWeRj65fKIqs+WNv7hEERiSZQQq3Ps2ALOP74oKxD8kLngH06U5tp?=
 =?us-ascii?Q?7PCosg/uR96WQ5mSZ8WISqr/uX2+tEbY81ePUy+dj33t906keyTqBVR+zS//?=
 =?us-ascii?Q?zxBNvEECtGfI2+8CShD8LZ3NHCBggIBaVqIqbpi3UTx7KPiVPOkORoNOb5nt?=
 =?us-ascii?Q?tB94wkeuGTI6rufkFORamGMNqlXCNaxU8ZPWCJ1B5/P+TURMkMMMqzpxGxOp?=
 =?us-ascii?Q?jrUdm8mjXa4jUJzYvGhA7tlbwia59UA9EWecXAkybGFIQTMvZhKzpU450oUU?=
 =?us-ascii?Q?A4VXD249MgwKRg2Q/HuhA0XFa6yx0n5eh25a0QT6/zcfb+rZASGgj5EeRyLH?=
 =?us-ascii?Q?oQbmnJ3hgmbFMHIHk1ZnLDYyxcfh+ANJxNspYfP/9tL1gWYPq1RN8EBFXLij?=
 =?us-ascii?Q?Z7NB9qwgMpFd3mAtIC/IW53xLqT0l0AV+7AgyTVDN45gv4dotJ783/QvG5ng?=
 =?us-ascii?Q?/UJWrfv3Ivz97yetNTqvqWqnf3P1y8FL8DzssaqxWGwaYZ66o1JX63E7Jetv?=
 =?us-ascii?Q?KhLk2fW/JI/WlpfcfTtFR9NN/Wvqu52/TVjOqlD5fY0IImaBpARjBC5DydfU?=
 =?us-ascii?Q?b3Amk+ztr1yxGDifRmBChf+royUTsN0OjNoqyLdp4WQbUbUux4hyo5tkmSaz?=
 =?us-ascii?Q?ooP9L+xeNSBHqIGr2ZkF5jO9oqr2hie5HJD187GJhprmtCOPeNdUAlG4I1Qm?=
 =?us-ascii?Q?F/9X/BxBC1ynpUatswQvPfpZPNqNJ4/mbby6mdYBMjSgy6PZ0fjVuvLAtenG?=
 =?us-ascii?Q?jOaZ2iuN1R2XuZEezVw6yBUWr10YRzfseG0hUV9VeUk0hly/S14L33CMnLKv?=
 =?us-ascii?Q?rFssExaHcb8+eQEC5hrlpDxa4DVN/cr3TxZqKhfI7HHeUMpbuxOClnt9rnu9?=
 =?us-ascii?Q?WV33qe1uddtg9hKoycBxGYrtOpYxCyjb+NOyriBDqgLD2H0+RRqDDLyZFZ7q?=
 =?us-ascii?Q?Qey/i146Xc1AF4JGXb4VpELCej2KYE19RaZUUSGGTBwYvuXvr8bX69CZYoK7?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfb4a27-8c4c-472c-7254-08da749fbc96
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 15:57:44.0975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Edqia75uoPn4+/Q5CWjGejoPcLPI0OAu4ipVDjnqJfm1XO8cKmxIeer3UBGjv2VtjK51Zw8cjI1Ur1152LWxWUWPIOiz+LqAlwoSIeUafCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_11,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208020074
X-Proofpoint-ORIG-GUID: mwhU-lliubU4gDiidW_K9TR29uyyRD4N
X-Proofpoint-GUID: mwhU-lliubU4gDiidW_K9TR29uyyRD4N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> For functions GCC generates a BTF_KIND_FUNC entry, which has no linkage
>> information, or so we thought: I just looked at bpftool/btf.c and I
>> found the linkage info for function types is expected to be encoded in
>> the vlen field of BTF_KIND_FUNC entries (why not adding a btf_func
>> instead???) which is surprising to say the least.
>>
>> We are changing GCC to encode the linkage info in vlen for these types.
>> Thanks for reporting this.
>
> Patch sent to GCC upstream:
> https://gcc.gnu.org/pipermail/gcc-patches/2022-July/598090.html

FYI this is now applied in GCC master.
