Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB0857D35F
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 20:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiGUSfj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 14:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGUSfh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 14:35:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D796D54C
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 11:35:32 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LG8nkr000829;
        Thu, 21 Jul 2022 11:35:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5yKR1e3Aa9I8SytCQnfuYcIZscxRQkto93ymNUCcvbA=;
 b=jHcXFXnYCdNeQBBkOVuj/ltgs5au0rpWHwigco1WWvqCqv4Q8+1WgWpLXYUNqCg+iYGO
 efC91MXmV0C3S5S1y/EqjT6DiQoQ5RB8T/DShCJH5TyX3CrROtePPgh3hy7Gf785jdYr
 GEGUS2kHbjVVI24n3ETVxt84HF7Lf1hNsWI= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hf7742egb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 11:35:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgvwqTGpxsrN20OctwHZL6YTLD6FdWgk7PJUwP7lPtbrhsx6s/9ErFJxnFJ8mMaRTuxyiqFJpObqjAqjsLU9CFcJUN8zjuRsDe/Sb07GtTg3cqPhaXbENYy6t+4wxaxP3cWv8ZrTpxBL/6zZnKGWUbylAWWisvoMflIrEoOwEU8IelSBcNkxQRH5ZG3VgdYOqny/V2f3YlLFKRfft4v4Cx7TFUhgm6Y3uE9xCmak2/9YVI9vkSw/uQ+Z+m1ncKo6YISLdWHMuwU1fX5htITlHtDPmroggGAWF4czdRYzN3+yGiqS2vblF4Bq4rUgTvJ3YxwQsV+XstdGyLiLedB+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goc5FAM/PH9PPutIgNu5kyz5F4ZeZQCB7kNTmHg03nc=;
 b=i8K4HZ37PDltCeomaQAvBhXacnnhwT10PUJFR7MvJtll7hZ5zNi47oscq5Q/ALIjdrY20aF7QfDn2pfykot7oVcpemfh6rcVyUsFngny1x0O6GIVjdcFsNKJxk3betvV/bO7QkYsrNxc8Lu3hqPI54gZ2Lxt8rscKj7X3JMQD+A9WFKX24uJS6rDA4IzCBGj168ACpnrAE+kIBV8nw31ziDfV23c8Hz0m7weDAp2J/ozQIVM+xkIz0XyFWSqXp4siaebV2/l64NzZw9qmVHPF/mCfeOFJ6GhPfLCzLnUwSEwdNW4HKZbI2+Wuj5zZmgWTCGUf4jehWjhPmyJ3wBPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN7PR15MB2401.namprd15.prod.outlook.com (2603:10b6:406:89::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 18:35:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 18:35:25 +0000
Message-ID: <a73586ad-f2dc-0401-1eba-2004357b7edf@fb.com>
Date:   Thu, 21 Jul 2022 11:35:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: Signedness of char in BTF
Content-Language: en-US
To:     Lorenz Bauer <oss@lmb.io>, andrii@kernel.org, bpf@vger.kernel.org
References: <3fcf2cb7-8d27-4649-b943-7c58e838664a@www.fastmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <3fcf2cb7-8d27-4649-b943-7c58e838664a@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY5PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:180::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 201723f3-2ebb-49e9-c054-08da6b47c719
X-MS-TrafficTypeDiagnostic: BN7PR15MB2401:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ao2VFgpxM6MZPHe8LU5knLSRPMlGIm0iFQK8giWUTXjLmcBE6RX2t2Ztq1V5GRx31foqnSgGIY0elA7N1VFDH7jZ9XxoRQhIYYMMKdSDHW2oGuZqHpaS48Xdzqbnby04a01lf+rMbI45DZb4mCi7aHkh6vEUMm4LKh/E4KF9UpHLnWy3l4nBa4S612P51xXG98hy3WNXEK5TnZHCjPZf4n9HONHz+E2TxZGM9TDfdMicar5ut+ujIsRqgjg0Fzu9UqeCMrmq3AITSSxkH/t9FS3fh1GM9+zkgVwjq1Qm2QGy+WgT0OM2olnA3vTlX58cQGZakxeDY1rZkoGB4h2ER/KnkZ0pMiKGf65DH4sTqxTzB2yur7GB299YReRCMiwLhcTeAycL80wwADoZX8cw4bNo/+l49xdX6gFW6ztZ9ylR6umrWfFlkLnP+R++UPCVI0+fkW9vZ/yTFErVSVxj/P4Xj5KpYKpLP/Jy5eHQcPDNBGSl9aPSMbGbDc5Iu2RB01TM2WrPZP4tnhkdzEEgX34KKR+QiZgFR5N+Pu47Zo3ru1fwVST9EcCtCuT1WWsNf8jGBIxMe4sLAKH2jSXHalsVCXwXJDV3Y2/A/IJI0oV8ZgNnVN3aEABVrMJpOfkOndkoteLIQrDBFZRkarJsAbAFR354A+GJcMi70zHd2ATtZsLKN5cKSUGN8OE2A1lSXXI9864Ar4MGCUq62ySTmC1rQ8d66eYWxnwjv8MTPx8Ku2G7PDbMcROqzpVNlz57k0Y2//XDIQYKFMko58uqDVziJLWeD+N0KKslnywrEGP8Td5iPrhGPNieLO6MxK8dPYp9mGMsjuTUI35UVZWImmzK3WLS8r89JfXzbEW7anXlhZDBxBQfYARpwLvN6ydP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(5660300002)(2906002)(8936002)(31686004)(38100700002)(66556008)(186003)(6486002)(36756003)(316002)(8676002)(2616005)(66946007)(66476007)(6512007)(86362001)(966005)(6666004)(31696002)(53546011)(41300700001)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDJDNkRmWWwzQ0M4WUt0QTdjUXVzZHdxR1dTdmhqd0lsTVNYZnY4d1pOSDI0?=
 =?utf-8?B?NzZNNDZpZ0ZieWI0SGgvRkhlTDhMY3NSSVEyM3pDN25KWXMycHk4VGM5MkF3?=
 =?utf-8?B?QmlpMUNjSFk3bXh1bFdieEJsMWNOVzN0ZWhqY04rekVzOXJkMSt0VXZrUWVk?=
 =?utf-8?B?WU5rQ2wvZkowRUZrV0VVK2tsZ0dyTU81Y2F4ZFRWV2prSnNEeG04UG01Y0tS?=
 =?utf-8?B?bCtsMHpxVTRDZWFLbkFDSGlOcVB0clNxTHlqN3hpTjVvWS96bC9wczc2Kytn?=
 =?utf-8?B?YTZsK0Nhak5uYXFOdFJCVmRXdnM5eU5hOWUram12c1NoMTlpeEpScHdHN01Y?=
 =?utf-8?B?V2NrSG43Q1hxQWJGZTRtdkJieVYzYis2cVVVaTBpVEI3U0dORkZ6Qkd0TmQ2?=
 =?utf-8?B?NEJOZWxDYlJGREZSOVptc2lIZFNSR200c2pzYk53R3krOUdyZ2dXcmNNMW5l?=
 =?utf-8?B?ZjJTM3VTRkVwSnZoYjV1dTgwOTJhTW1LeWpUb3hhR01RdHVhM0o4c1g3UDVl?=
 =?utf-8?B?WjJIT2pSZHFCU0lvTXc3WUZaSUF0eVM3TmZpL1dTeFBGaitUMGg1S0tvRk5O?=
 =?utf-8?B?djZ4WmVBRHZ6d0lIOVpYVEllUVVkVGs0c0psc3hlbU9TdkhDcFhKVGlWaGF2?=
 =?utf-8?B?NVU1T1VKOWhiUENmNU42L2VURldCNlljbVpvR3hUZGUzVTdMVE5hZ3FOMnBF?=
 =?utf-8?B?NCtoZFNJVUgzbGQ5ZWtoOFN2TkZGTG5WUGE0MkxuKzFTOTBxZzJwM0VtdmpD?=
 =?utf-8?B?S0NPVERIUW1ha05LZ1lDTU1ObVI0REZoLzRqaFFacERDNWFjdkRXY3VaVWpV?=
 =?utf-8?B?bVBuczJLcGR5N1pmQXNVOHJ4UklESy8va1Zrd0hubnhSbS9XQ0RHSGNxMFhZ?=
 =?utf-8?B?SC9lNVMwMWJWT0h4K1BZYkVqTGxlcUszczZGL2dKT0pVWWdqQ3RCMEFSdnE0?=
 =?utf-8?B?aGkxZC9tQ2JvYXVmTDlHVlZ4TUxPNUJCS3VVVG9JU1JzQmcwdUl5U2ptTjgv?=
 =?utf-8?B?RER3NytXVmlaa0tTNXoyNzFYc0luMFp6cnVEK3hodWY3QWl0Z0c5Zm4rRHRa?=
 =?utf-8?B?dktSM3Y3WDVlWGZHTC8zV0ZMZ2VKK1V2TFpNVXczWGJiM3V5L3dvSW1Pc1hF?=
 =?utf-8?B?dXlRVHBQRHpsajBEdG94a2xMYkk2TDBWTmhOemgrZktZQ3JmM2taWTlEYjlU?=
 =?utf-8?B?dzlhME9HUVhTS2NJSkdHL1c5TWZoVFg3K1BtVDZHeTU5VXRWVEIvQy9kYzI3?=
 =?utf-8?B?K0ZiWTlmNzRVck9NRVljZ1d5RTczOTJQR29wMi9KLzNEbEZBREpVTG5HYXp5?=
 =?utf-8?B?MFhYTk9kcER3Sm9TVjV0NlpZem0zQ05uVEZ5ajRUbjBYVEtFdkFRTSsydlBC?=
 =?utf-8?B?TU03VWJHZTErOHk3c1FadXlvN3pvczZqR0ZGbDZZb2ZlSkV0QXNLVnFVUUNn?=
 =?utf-8?B?TlpzMVV6Y2NEcmFNanhxMDBHRUZYRndIU1AzdlFTZ2xmMG5mRkZLR1BjbjZo?=
 =?utf-8?B?djBDazJrSVNPVTVYL3dRSzZaSlFhNzhMemJYZXRGN2lKSWFOQUlWQjBiZFZm?=
 =?utf-8?B?RTc1R2d6MC80emFUNFR3MXdlK25BalpMOU40SEhJWmZ5Mk5JMklOVFl2eVRB?=
 =?utf-8?B?M3lVeTVubGZoRjdMWFhYNHhsQnBFY1FCSzhkOGo4aHlHQ3Flb1BnMjV6cHo2?=
 =?utf-8?B?NmZQa1RlTG9QTFpzbXRSVDBqNERiMm9rUThVYW9ERjEzd2gxa1dmWjcwQXFu?=
 =?utf-8?B?UFJNNXhFakc2VDBMZjRFaG42M0R4WFpKVDVvRDNBR2lOQXJQc1NXc21PUmpG?=
 =?utf-8?B?SWNmRjlWbEhTQnk0KzdMbThOSTQ4c0RwU1crTFVicHRINWR5OGdiZXNhRlNv?=
 =?utf-8?B?THZaMWlmTENvK3Z0QUdYa25HNmdGZVFHVk1HTkU4cDdNQ0x5YXRYRmd6NjA5?=
 =?utf-8?B?VXdML0ppUEVOZmdmK1h0a1RITS9BZHNaQjVhLy9HdUhrNVlPVTZNdS94K1o2?=
 =?utf-8?B?dWtocGZETEx6Z2Z2NmNwT1lZTmZQamhPd1ZkRUxQaEFNckVLKzlxSE51Ylcv?=
 =?utf-8?B?UXdjV0FKb2hZRlp6UGN4eENjYlREUWJvUGsvL2dCTjNybUhMOXJvakE3RE1H?=
 =?utf-8?B?ZmR5dDh1NXdDMHlxbWsrem5mWWwwQ0JYaTBLZ1NHeVRhb0F1NFNvSGlxYUNB?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201723f3-2ebb-49e9-c054-08da6b47c719
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 18:35:25.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+2qky7AaZS2+9qM6L4lJq6mbAxWMsCJyc2BodSP6LE9E/E51BHVFWA06JDOXPNY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2401
X-Proofpoint-GUID: 1zJ0AxIkTOlfE0101W2Rg3KPz0E0CdW-
X-Proofpoint-ORIG-GUID: 1zJ0AxIkTOlfE0101W2Rg3KPz0E0CdW-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_25,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/21/22 7:31 AM, Lorenz Bauer wrote:
> Hi Yonghong and Andrii,
> 
> I have some questions re: signedness of chars in BTF. According to [1] BTF_INT_ENCODING() may be one of SIGNED, CHAR or BOOL. If I read [2] correctly the signedness of char is implementation defined. Does this mean that I need to know which implementation generated the BTF to interpret CHAR correctly?
> 
> Somewhat related, how to I make clang emit BTF_INT_CHAR in the first place? I've tried with clang-14, but only ever get
> 
>      [6] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
>      [6] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
> 
> The kernel seems to agree that CHAR isn't a thing [3].

clang does not generate BTF_INT_CHAR.

BTFTypeInt::BTFTypeInt(uint32_t Encoding, uint32_t SizeInBits,
                        uint32_t OffsetInBits, StringRef TypeName)
     : Name(TypeName) {
   // Translate IR int encoding to BTF int encoding.
   uint8_t BTFEncoding;
   switch (Encoding) {
   case dwarf::DW_ATE_boolean:
     BTFEncoding = BTF::INT_BOOL;
     break;
   case dwarf::DW_ATE_signed:
   case dwarf::DW_ATE_signed_char:
     BTFEncoding = BTF::INT_SIGNED;
     break;
   case dwarf::DW_ATE_unsigned:
   case dwarf::DW_ATE_unsigned_char:
     BTFEncoding = 0;  /* INT_UNSIGNED */
     break;
   default:
     llvm_unreachable("Unknown BTFTypeInt Encoding");
   }

pahole does not generate INT_CHAR type either.
in pahole:

static int32_t btf_encoder__add_base_type(struct btf_encoder *encoder, 
const struct base_type *bt, co
nst char *name)
{
         const struct btf_type *t;
         uint8_t encoding = 0;  /* unsigned */
         uint16_t byte_sz;
         int32_t id;

         if (bt->is_signed) {
                 encoding = BTF_INT_SIGNED;
         } else if (bt->is_bool) {
                 encoding = BTF_INT_BOOL;
         } else if (bt->float_type && encoder->gen_floats) {
                 /* for floats */
         }
         ...
}

So for both clang and pahole, CHAR goes to INT_SIGNED or INT_UNSIGNED.

The reason is originally BTF tries to mimic CTF but a
simplified version, and CTF has CTF_TYPE_INT_CHAR, but later on
found BTF_INT_CHAR is not that useful so llvm and pahole
doesn't generate it any more.

The libbpf and kernel still supports BTF_INT_CHAR and when it is used
to print out values it is interpreted as type 'char'.

> 
> Thanks!
> Lorenz
> 
> 1: https://www.kernel.org/doc/html/latest/bpf/btf.html#btf-kind-int
> 2: https://stackoverflow.com/a/2054941/19544965
> 3: https://sourcegraph.com/github.com/torvalds/linux@353f7988dd8413c47718f7ca79c030b6fb62cfe5/-/blob/kernel/bpf/btf.c?L2928-2934
