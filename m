Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466C157D6D3
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 00:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiGUWWL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 18:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiGUWWK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 18:22:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3B818B2C
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 15:22:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LJg6tv015365;
        Thu, 21 Jul 2022 22:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=yiOwWAJgK6oC75JOAOrL7gdtAhEmWRJZQDxyVTpc+Ns=;
 b=MyNdXqqcq5+h/6638d5kKUcEfYvfZ/H4cYCnSg5gKYk8irXhZRf2DG5Mqvf69gbe5ayc
 /MMwLe+j6XOQsoHXy0IsBzUq6or5pP/ZFTejd62MVqzbLqQkOmh6wlQJnv364x7If2HA
 TBNVpOY9dAxmALQiuCypfSsY4dR+G1DHHNh3pizN4rojXp5R0FlKAzooRgS3HwTtdEqb
 e9v304NQkqpR5QnarHf8KUK6RyWDvNlXVpZPuAh0KmjtBQDiQrMg5N/OWQ5kpjBdTpMO
 BPZBdUmHWhf5H6HqL6k25p9qYTs8Mhv0Npra/8U3UeC6uVTcKk+ymxa7C4fNpV66dWVq qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7admuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 22:21:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LJqbIr002810;
        Thu, 21 Jul 2022 22:21:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mdpg10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 22:21:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiDiR2eb0le6lrXuXLxoSWbM4GhNoMeiADLedhQ8ey08IEisaqnfnOVLJyjECXsjubNa1lIAgBK9y6OejNMMJX2LicIOYgjBeIuO0ralpVl0rzcJMsQf55Oc2bEJ+Ohj63TaQD8BNt/3xv8zsA8BYOoLO5ekqpxTfaJkpWXGOO7AfFcfslCISyGqSAvhmoG3FSyLc6HpfEd2F0zBGoTZxG/FTQpjxjyf5huMu+9AbPDvUBEBid4mEuhcEzFytgOYRUVemUgwiOyu8taELKH4E9lkZcis8M6qOE+7d8QYGnr56pFrPuBiRIf3MljcVHaJBAzXsnGykqglTSVxHJTGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiOwWAJgK6oC75JOAOrL7gdtAhEmWRJZQDxyVTpc+Ns=;
 b=HHIbvNzsBKRT1YFopqBymobuVc6MVih+Ou53bw8Tye5bKaIjkvn1SfvL1NNUj9mLH9INS/K0jMilAn2gFCLn4IQGsXrLlYz7q/xSPcqNxLyAWZJT5LKDwPxOFsFRcuexIx7flKro8thL1fzSID8omfwfhn4JlGCE7oWlco8KbojdJWcQDXMUH5ngGYVjQGZNz4PoBdJ/Br93/mJIw9b2tMPxtrwbocKLvBSN/C9bAHqZvJPL3i6cVQKtBFV0Yl4IUM8V7BPo5rn9VacFKY271/Cj3gFTNwQlvq+OkcnCWPRlOmIzVvp2hxsbKAv4S3lLrtgx1xr638W4wHYBGLlgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiOwWAJgK6oC75JOAOrL7gdtAhEmWRJZQDxyVTpc+Ns=;
 b=DfQJYkyRIFFdZ99/CA5CiczcEBVc/z37yZ6hd//To2k4H/3KC/NiX9lVKDqgWM58iPpGXwDb2UwUEu4iMTKmtSIdFR2EHoVXCCKWgyc1RUnUQRvtWvYK/T62blLgJ9eq7qrVfevpQKVDHh2/nmiQaEED0NZmoSRB/N4SHQQ/xv0=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BN6PR1001MB2099.namprd10.prod.outlook.com (2603:10b6:405:2c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 22:21:55 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::b5ee:262a:b151:2fdd]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::b5ee:262a:b151:2fdd%4]) with mapi id 15.20.5438.024; Thu, 21 Jul 2022
 22:21:55 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Lorenz Bauer <oss@lmb.io>, andrii@kernel.org, bpf@vger.kernel.org,
        david.faust@oracle.com
Subject: Re: Signedness of char in BTF
References: <3fcf2cb7-8d27-4649-b943-7c58e838664a@www.fastmail.com>
        <87wnc6bjny.fsf@oracle.com>
        <e636b480-8d53-a628-bacf-bac2b1506a47@fb.com>
Date:   Fri, 22 Jul 2022 00:21:40 +0200
In-Reply-To: <e636b480-8d53-a628-bacf-bac2b1506a47@fb.com> (Yonghong Song's
        message of "Thu, 21 Jul 2022 11:44:33 -0700")
Message-ID: <875yjqayyz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0034.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::47) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ec37290-cc30-4414-aec5-08da6b676b75
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2099:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAYE45xT2FiJxMUUq8/DVhUyOOW7ZSkWkiOL5E/w86iWpxUV3Fcg6bXw5t9V0qLdwmz4lrM6UwHJGoaEiQSwBuD+XOg2D2j5bP+dyxrMRK9iEsq/OgArXxM2g+5lZk+oaLWh5L/sAEB7l8xLrxHpf7A+VgfyrIofTWExyd7EGrCbO6rJ1cW0WQNWlpNEafTRQ3LmxHBCLXSzK8zKguOznRV1t1qopE5LMpzJ63qCOeq5I8r4kMPhIqJvhpsB0vqgwI2Ey9fa9jIjzZQ38vNuRjmCRKe5Tns64oOzqYqtlu4iWHSrODyp3KxszZzWTJJIRzZ7QyT+A7VZyeNX2Q7IgOvicjyf2M0GbzN+zdwJ9Dw9+JpfGmqavC4HuukxB58yt5Puu3SyFVXp7DfMnmQQ7ETy6MOaIbFyjD95NrQM4Wm2ernEPRqJKAkIGjIFpdp3kolp2dHuTvqgXDUUo1hcAtBcgmaWRK2YZX7pY9wMdcrBXRGW9wDbRTNWfizcdWIF5f4C17lWef9VuYrh0ACpm+zHAcrvtOYNfBvzeZXDNmUaZ64nVmDn1KpLev06ryxPtg72AbnTZl0UusebQidtNivzrxJNJMmAnJgCzud+Vj6lzaNMjkke93nqLcfr8NfcDqMbbMWIaYZNarg8Rawj30YB4jcx4DRbRdnUyWfht009AR+2zTJAU4SsTX0jaVwDySX0HwtPO4tZD2ukYHLjXymBV78RU1eRnaSRlXwLGHnf1ttBFIKXeJ3y7Je0Pem0xry0RpDr1EEJt7nTCz2JHB0h0HcAOUXXuRXIZzKdZd2AptzQh7hvCLwC2GEEB3yGtNFDmHHOU54FheuT6vWAcr04gPnAsNDKesAdzBTJImJ5GLTnnRmCgm6aZbkaPsSn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(346002)(136003)(396003)(2616005)(38350700002)(66946007)(38100700002)(4326008)(41300700001)(66556008)(52116002)(66476007)(6506007)(8676002)(6486002)(966005)(86362001)(36756003)(53546011)(478600001)(6666004)(107886003)(5660300002)(6512007)(2906002)(26005)(6916009)(186003)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VjWnZKL1vTUPGjEM5gTa77j8c8VMlT4ew3H0Ofxv80ZZAPbVACXHXhWjgxSD?=
 =?us-ascii?Q?vlzBrL6YQ4Q8Kf/hMM4LuJQ1neI0elNnRfcdFIEMTxkqR1f/ljnWTK+kz6FZ?=
 =?us-ascii?Q?G+FhsKb9XPGj/rLATo3HAVJRfHSgZEo1QUxaGYe2zgWXzOya16Nld8XcHQjr?=
 =?us-ascii?Q?PmePf+7Quip1vtNqPCfy2gqo4XACRWy58BRY3/VpqCTwo8OsRg5+Lr0WTY++?=
 =?us-ascii?Q?xB6uEtCjdMhBGCzZHgSkLxKlYUC69EzHbR08V2wDN7fO+3arZmzebamAxNsE?=
 =?us-ascii?Q?qDx9iNMqK0DLQ95lecanG3zGzobocAJHsVhcZiUvLN9BZ7EaOJPu+gXHhRam?=
 =?us-ascii?Q?zLj+zIWov8n4eofObGjaCd2QpNsiXhYeqyJsbninWH0dmYnccpCSKwC2+Z8y?=
 =?us-ascii?Q?3zYdMfkEjrIqO2QK/LF9mWzIKViE8SPEHPe3bnByR1CllI7WjSe5CQK5KEig?=
 =?us-ascii?Q?0XxCobIPRR88jOTf9XvSM8D5NnTp5kGnemr0C5cSrle2siHqeT3ENtY+KH0c?=
 =?us-ascii?Q?8V/nIGiI2oyaiWfgHhJCX3EIYJOLoZGwLYYHt3N69Q86ku9NDsfINtuPREof?=
 =?us-ascii?Q?7IxSF2u10atIEjKMqaFPx2X/nCcw0Iupl/TXYMa2S6OyZbigxCHXWFH05ncZ?=
 =?us-ascii?Q?EJuqoQbC/CbHPTd0ObkvJBrsPhwXUzlYfLIBOgJTQipSBSWZ1zSTZZoeCn71?=
 =?us-ascii?Q?JaXu9eZIARZpgitq/ktb57Ws9bOOzhy5ET7J7SpIcrGqF9S0IOt252cwDeKA?=
 =?us-ascii?Q?AisP9Z6zt6OoxcdNxV1eG8e1pL6ubZbLMZg2CdtfhXQ4I3psHU4F/rLnI30P?=
 =?us-ascii?Q?VlCdmXkjDc6Na4qZUoap1GFyynJy/JhtlmVTmRLKve4wKamN1xvbOaktUK+b?=
 =?us-ascii?Q?g0XoZyIu5qOwCU2iCMixtgZOKH+IosGIDRDtMt0bq74YPEyKY9zdZ1RFch4y?=
 =?us-ascii?Q?Q42gRCDibpzUxXxjfUMNCL7T6eYL2H4qoLU4GXLn9MYWnOlzjY+IPM9iUI2s?=
 =?us-ascii?Q?Mw0s+aJjLJogtJ4iVco0q1MM6QEHgk0NaiGiBpXu3AeETcmtCbgi48hi9sM8?=
 =?us-ascii?Q?x/WufoTjLNlYsy2pKMm/g/sX72UgAWbRYqf7uZAkpr+uR3dJhry/WY3s7HWs?=
 =?us-ascii?Q?yUzlYh6GY4K++U8vtr+m5B6M7Ug2Xf+kpqh5FrnGfOPdOvvcrfJmqWkEnA1f?=
 =?us-ascii?Q?mSAkQGj35VXuJnWMVS02KcLpoVEsUCg2iLOzPiEimZNlBL531EHSFmE049nr?=
 =?us-ascii?Q?UZNJzQGUftuIUwcPSbz6Qxrxy0UzhFi/Z362gZ4UKnQ4H4NBCuxt1noChnhO?=
 =?us-ascii?Q?VbBp8HZEA4vRAxGjiGUDmwqqB6i9MmysNbEeScTz4rZCucW2uIuE1mjmvoqs?=
 =?us-ascii?Q?LxR5c35B/HaovblD/GmNIqXBafQrnVOo4VoLQCuiMAkHaEcR9Rq0tY7yvxj+?=
 =?us-ascii?Q?UG8fq9gt4CYZBSnurJq6ax77t/x+aJJE99uGSGP5b7XwRQcIwtM7y/C6hco8?=
 =?us-ascii?Q?IzSB1rNDMT710rbjXkw2o95XfE8UJT80dsNmTS3vDY6xGJYqEjKeFVZk7Mqn?=
 =?us-ascii?Q?uLrmS7GXJHcxTWhzNfLcUIZSSbLSPp2+g2twq1CcJ562kljhG0NEjDnxVKio?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec37290-cc30-4414-aec5-08da6b676b75
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 22:21:55.7368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCMRHQHCrWtJS/Zo20Mq1JsvwwcrOezqOaUnPrEXaqj/y6S+6cNeKMT8YOc4KDi7nqZc2Y4bZYg43wluJUmEBQYMtbXWtkExgpBoLH9RbCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210091
X-Proofpoint-ORIG-GUID: eQSsN5js8lNKHBracW5tgP43e_DL8G-p
X-Proofpoint-GUID: eQSsN5js8lNKHBracW5tgP43e_DL8G-p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi Yonghong.

> On 7/21/22 7:54 AM, Jose E. Marchesi wrote:
>> 
>>> Hi Yonghong and Andrii,
>>>
>>> I have some questions re: signedness of chars in BTF. According to [1]
>>> BTF_INT_ENCODING() may be one of SIGNED, CHAR or BOOL.
>> I have always assumed that the bits in `encoding' are non-exclusive
>> i.e. it is a bitmap, not an enumerated.
>
> Based on current BTF design, it is enumerated. So signed char
> is 'signed 1-byte int', unsigned char is 'unsigned 1-byte int'
> and 'char' could be BTF_INT_CHAR but since in debuginfo
> any 'char' has a signedness bit, so it is folded into
> 'signed 1-byte int' or 'unsigned 1-byte int'.

Ok, we will change GCC so it does the same thing.

What about BOOL?  I don't think we ever use that bit.  Does LLVM
generate it for any case?

>>> If I read [2] correctly the signedness of char is implementation
>>> defined. Does this mean that I need to know which implementation
>>> generated the BTF to interpret CHAR correctly?
>>>
>>> Somewhat related, how to I make clang emit BTF_INT_CHAR in the first
>>> place? I've tried with clang-14, but only ever get
>>>
>>>      [6] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
>>>      [6] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>> Hm, in GCC we currently generate:
>> [1] int 'unsigned char'(0x00000001U#B) size=0x00000001U#B
>> offset=0x00UB#b bits=0x08UB#b CHAR
>> [2] int 'char'(0x00000001U#B) size=0x00000001U#B offset=0x00UB#b bits=0x08UB#b SIGNED CHAR
>> Which turns out is not correct?
>> We used a signed type for `char' because that was what the LLVM BPF
>> toolchain uses, but then we assumed we had to emit the CHAR bit as
>> well... wrong assumption apparently (I just tried with clang 15 and it
>> doesn't set the CHAR bits for neither `char' nor `unsigned char').
>> But then what is the CHAR bit for?
>
> This is not generated by llvm or pahole but apparently it may still
> have some meaning when printing the value, a 'char c' may have
> a dump like 'c' instead of '0x63'. In kernel/bpf/btf.c, we have
>
>                 /*
>                  * BTF_INT_CHAR encoding never seems to be set for
>                  * char arrays, so if size is 1 and element is
>                  * printable as a char, we'll do that.
>                  */
>                 if (elem_size == 1)
>                         encoding = BTF_INT_CHAR;
>
>> 
>>> The kernel seems to agree that CHAR isn't a thing [3].
>>>
>>> Thanks!
>>> Lorenz
>>>
>>> 1: https://www.kernel.org/doc/html/latest/bpf/btf.html#btf-kind-int
>>> 2: https://stackoverflow.com/a/2054941/19544965
>>> 3:
>>> https://sourcegraph.com/github.com/torvalds/linux@353f7988dd8413c47718f7ca79c030b6fb62cfe5/-/blob/kernel/bpf/btf.c?L2928-2934
