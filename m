Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E29588105
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 19:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiHBR3D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 13:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbiHBR3C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 13:29:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6783248E96
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 10:29:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272HSToD016007;
        Tue, 2 Aug 2022 17:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=XnYeQ2OpFrTVj9kog+fk3VnN2kJHv4aJgcZrlandr6o=;
 b=QirNFBOmfPRIqoJ9Gx1c9yVs2CuuHgaOfLCcRS0PKIwEoxqlskISFY5egcJ0yru4Fu2J
 lci9ivHE37Tl8UmCNGDI8y8H72sXSf4ExqPwE61P4yovUcaDptxXyoo7RgNVKix4p97c
 607oqL93DEptrpkN5ZMj5zDEt74NXhi+OeOtey9TxkKgoUCv0c01XDXcSqs1L3gGxdp6
 CHfhv+m7Xw4trL9xCdYpIfLyqCNTX06Ah7C75Shlq4CwtJkwRIWXTWH8inbHweP8OLjZ
 ZNIH2Jdz4lPMoRyf4Jo0zMeyBas7HosHB2iqhM4QjXqO+Cx+7kBx6X6KsBKNI0WTNWRY BQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmue2qpf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 17:28:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 272G01mA001001;
        Tue, 2 Aug 2022 17:28:46 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57rdpg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 17:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXX1GgmB3pHhZOvrCUI1js5qpXoszt+6AN5uLhzad2jzSNyuFPgIKk6o+aJ9X7aFSJeSQlaNEG/4nHGVfnvuDUASqSyQskIyivJnbRxznPD24j1NciS6vDf7DyEv6hTtKkgyeAGeHn+ozdM/yMDYc+x23oQhEquaDVGdQoLNLteNFIjzh0Sj4k7dQnc69r830PUfKI9nt95TqdMTfGyIQXwjbZf1p6Sb9IdeozpIVDP8ERLgtWPZU6mQuBkgoDjlPHtPUkkkCK6wCs7MbfJFS7wE481Rpn/cIpHUVbXwNTKqasdO1ywWQWrfzQsRTpOYtxUrgYZ48FHCDxm/tYvjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnYeQ2OpFrTVj9kog+fk3VnN2kJHv4aJgcZrlandr6o=;
 b=oMadt0UE+4ELTIhyXYq0TiPjkwYfS8PTcYeiBPlDTYgmBPYgxboXdZsuLdfz9s38SFUt9cIt3vWwlx+NBReFCpQXEsrPA0vtUr+XxqXxCNeUjDXjOnoNAV9TKsJwqoHogdn5/vHi8XO/YN7dMvI1s3wA2GRHj2rb2JaD4WFL6TLee09pDGwRpnxtmsBqkYrtkMfNxTs9kesww7fDjvzoBuSUDOU34Hdz8vjn2b09ITTi+w+om4OygTJtkaZ8jjwxCaZNe6CBHt9Ol59fPB3BTzKdTIPl4Qetk65z7X57Vwy/2KoPuzQvaWZScj+9IdmUyxBi3+ruVyGFa6aHt3FI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnYeQ2OpFrTVj9kog+fk3VnN2kJHv4aJgcZrlandr6o=;
 b=wtvTF6/I+USKs1e3Gg345DaDViXYuwHkzyWLltsk/rac237td83q9wNxjB2jCl1WtAwPQMS5U2qlxx6DZ2pZv5uCo+x/witTILNhUxTVL8GIYVa87ND79168+caWoOhOf44XzuZkU4o/jcEt4aHoN3D/eS36wBNWtJGRph6PgL8=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BYAPR10MB3013.namprd10.prod.outlook.com (2603:10b6:a03:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 17:28:44 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::b5ee:262a:b151:2fdd]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::b5ee:262a:b151:2fdd%4]) with mapi id 15.20.5458.024; Tue, 2 Aug 2022
 17:28:44 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Lorenz Bauer <oss@lmb.io>, andrii@kernel.org, bpf@vger.kernel.org,
        david.faust@oracle.com
Subject: Re: Signedness of char in BTF
References: <3fcf2cb7-8d27-4649-b943-7c58e838664a@www.fastmail.com>
        <87wnc6bjny.fsf@oracle.com>
        <e636b480-8d53-a628-bacf-bac2b1506a47@fb.com>
        <875yjqayyz.fsf@oracle.com>
        <d56865b1-30dd-8761-2c12-ae5f66778de1@fb.com>
        <8735et8k42.fsf@oracle.com>
Date:   Tue, 02 Aug 2022 19:28:36 +0200
In-Reply-To: <8735et8k42.fsf@oracle.com> (Jose E. Marchesi's message of "Fri,
        22 Jul 2022 13:25:33 +0200")
Message-ID: <87mtcma723.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0088.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::21) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ebc908b-d23b-40fc-3e60-08da74ac733b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3013:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLrdFVA2Zkz0A04ViTxzIq4gk1WqIDIKcJylZVESas1V1LxEOwRB7q18G+6iqbglhTKyQxsMGWRZBipnRTyWZb7OfbWpLXKiJsEiWl8pyAw9fZaUy/9TMKuwp5zA3/VEh9WU4M54KU2LY+YOvZF8FIPi1WHZ4/o740bHKhiaW1F+X2NePP0gqkcpXqBihT0iuLvLqz/1M5hyQ977pClne6l0yawqJZ0yfnRrt8PU6+rtD2K7wpIDJJ8uUkPW/0RNt3ywRJy9/F+GZpv7TWemIM6vFH0qCdeUnaV66znldSghbmWt/u8S+G1wpC3fDACLUPWc0rKnpWHy6v6MzXHbNC1mCJGVOcTgsq+iQKsl1kSKK1Q8yOI0jqqAaHuJRIPxwCOxDlVXzoQi9x5YjjvMXseEhZdAfVQqkKwUWEhmxJNpKeaVsiOwCleQ0nZ33lNNuxAKCakuPYVlva2E5jIczDfWO/kw6ijhaO6WPTqr9eN4BUrfbSeKs5MSSpEi+1SV9BpwHH8TjOrVSBvcwklKv1S7W6x+oCBPfTZM+8Y0xAn802ueOl6ItDNX2TD7WLWqWVUQJlBAk5iaW/sEancBj6t1vx4g1UB4GBNoyEpIlCqsxSH2sEmwsh38DEckK6zMzi/uN6EZ3HEEaVUgBt2/Vyb0MK4tW0oOsJZSEQmH0lagbB5iPN/xxXDMB7wu5STEBH1v0749OFVJQqrUg31ahzo15RJHKODdbEhxB6PKUjNWsQ5A4L6ZylgAO/W7i9XyOw6XblhyGiZTfjmbhQErU4ffXGvBBNIwmZ85aYVln9JgyipgLmOoglBoCk+RYVh+ZbWdkVXHFzJHB7UDS8Gmpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(39860400002)(396003)(376002)(4326008)(316002)(4744005)(8676002)(52116002)(86362001)(5660300002)(66946007)(66476007)(66556008)(186003)(6666004)(6506007)(2616005)(107886003)(8936002)(38100700002)(36756003)(41300700001)(966005)(2906002)(6486002)(38350700002)(478600001)(6916009)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I+8MTmbD2v0hhS8J4E4D6U+Qa/3vfAslHLyVimYDubGELVh4TcKl1wCkSZLB?=
 =?us-ascii?Q?MkboMj0BxLYe5FqvXBo7Ni2066fNugHQ0MwYD51sHZvkVyu0iEohvIvRSNjb?=
 =?us-ascii?Q?X7YG34Q+wpFy7sFcT+LLDnBHTrGqegfEKS22NeQCgeiM/FRBU56evHBxkDlW?=
 =?us-ascii?Q?cec2JW1E7mUgsmYmDCmXrqga3ZsD9aKr0Yxh6qy83r6qL/mHg7+41+Kztqrs?=
 =?us-ascii?Q?rHatTODe8BqJktVP+gX0x7QoDeenqOr3AfNGtpk+5QnE+WdKBwQHFZSUISU7?=
 =?us-ascii?Q?aAmlYQu/Ptw16LWyXJza1dzv25YHZ1e9NUSDXrE0CURmTONyWuX2mRIdAzUD?=
 =?us-ascii?Q?R9/m6qtzxPbdFJO2UHsgIKPnA5s85ld9wNkvM10BYn4Up9NuwF0LL1qna0gT?=
 =?us-ascii?Q?HeyXdk80Xbn02PAZDUKkWqwKHymp9uj7Aaw7+imoUYTOvhV4k/IVm28HC3ib?=
 =?us-ascii?Q?asIseT5iH8dppzBVoHik8USGosJfAZPi++OyZEZamXZ60IQPqQNfLTiSNNY6?=
 =?us-ascii?Q?lT8uTsfBRQWqVcx3+EI7Me7yNk9SGDUxs+PtY3LAAUQ/0P1Yw7Yo55VvKzNj?=
 =?us-ascii?Q?HIAO2p6NXnAM0C1WhgWcBiuq+ByvTp/wARKFVNS9qWpXgFlDPS9XoB6qwdZ8?=
 =?us-ascii?Q?MVyTHuOw8d/yiacY/BYGr130CwTyVvY1AIGxIgdFzqSjdlTEYlg8TC7ozmoL?=
 =?us-ascii?Q?AjHiMdb9rt6o4FqeDEsZ7MFnpSSmVsxd7uqzx9PCihYj+D+dgmg45IxYhgl2?=
 =?us-ascii?Q?WVKUmJYaVt6Tup1+sLcIM9nbBl3hTW4Y23psYvaZfJ2Nu27zt/baCLadAQDv?=
 =?us-ascii?Q?og8UNYQS81um7wYHW5CcPW+/gcI7S+Cemx7wgRcNcomwQ8Y1BAAg72fbns2Y?=
 =?us-ascii?Q?o742RVc9efuEoSz4aElXVlSWtAqCUiaqO8RiBNNcFwGMPBmM84J6V9EOHD/W?=
 =?us-ascii?Q?OcAdpjc101f77eqXb/RcyW2AfECFOG1AMev/C7J7s29mRAhEjrjsBGNyjqyW?=
 =?us-ascii?Q?J+rQYjaAGoRYhnKViGaHb2wwuFJ3+xR8PIW4RXmknvGkdZ7oidJ94BEhV8px?=
 =?us-ascii?Q?a5ZmcL7uChIOWCGqAXRJi/UOI5keLH1SSJisW2EYkph43w1r8lOOqI70H1QO?=
 =?us-ascii?Q?puwDKUWm8fbAp1VS4lgoWv0OXS1++1w4XVTcUsspy+48CvBbFc2S2T5QR/dS?=
 =?us-ascii?Q?3Nv+CRI5iInFD7FCTzfPKNPHEs0MR1/q5OprVYHCCXL6BFPeb6vNfARWiSvX?=
 =?us-ascii?Q?zjmhO7g09Ds8I0YnuNc0Z4y/PJwvXkS7qbvW+wrqsPpWVck46vIzaii2sQji?=
 =?us-ascii?Q?kM09aFiAVKgKObYBEoy00mQ5PjwYtjZnUs2hKY11kQR/gSy2anGiUcDJCQof?=
 =?us-ascii?Q?arp5KGUDvVp34AanGtj3KxYzrEJt6CN0eb+5WpOxQOR7SG4Ru2aS41LQJX2z?=
 =?us-ascii?Q?eTjVbqG058xJVgYLqM/XLTMwjxt+p2NHqXdw0OgbxIU/qZl6iN3yUM3bFgqR?=
 =?us-ascii?Q?ek1+FeFnvdsleqCooz90qHAHhqQizva6jwcO0dJujQuPQR+9KbyGeJDrTPzQ?=
 =?us-ascii?Q?h3Hs5+udVLRH0OBrw48Rcb9KKf7Jo4pYXpSlXki4oNIMBsaNoILjbAVf70VZ?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebc908b-d23b-40fc-3e60-08da74ac733b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 17:28:44.4211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5vxJDeMkFegmGWKrgbnbsviSkBWpM9d1d89Q2QqIBP5T+DsQecIBVnpUF9ouvBnHZbVsR6nxs0lQHiEpD2ODeEqMFx82QelXhpJZnYprH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_13,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208020083
X-Proofpoint-ORIG-GUID: BZMiWcLQ746LVmJpRDwEfuEFIauxGV77
X-Proofpoint-GUID: BZMiWcLQ746LVmJpRDwEfuEFIauxGV77
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> The llvm and pahole generate BTF_INT_BOOL when the dwarf type has
>> attribute DW_ATE_boolean.
>> But BTF_INT_BOOL is actually used in libbpf to differentiate
>> configuration values (CONFIG_* = 'y' vs. CONFIG_* = <value>)
>>
>> In llvm,
>>   uint8_t BTFEncoding;
>>   switch (Encoding) {
>>   case dwarf::DW_ATE_boolean:
>>     BTFEncoding = BTF::INT_BOOL;
>>     break;
>>   case dwarf::DW_ATE_signed:
>>   case dwarf::DW_ATE_signed_char:
>>     BTFEncoding = BTF::INT_SIGNED;
>>     break;
>>   case dwarf::DW_ATE_unsigned:
>>   case dwarf::DW_ATE_unsigned_char:
>>     BTFEncoding = 0;
>>     break;
>>   default:
>>     llvm_unreachable("Unknown BTFTypeInt Encoding");
>>   }
>
> I just sent a patch to make GCC behave the same way:
> https://gcc.gnu.org/pipermail/gcc-patches/2022-July/598702.html

This patch is now applied in GCC master.
