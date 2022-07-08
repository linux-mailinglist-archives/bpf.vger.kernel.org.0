Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E8456C0A4
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbiGHSd7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 14:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbiGHSd4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 14:33:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D16205DC
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 11:33:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268IEDmW016705;
        Fri, 8 Jul 2022 18:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=KEx72V+vsxuBYnUTwHUJqyeyQSfBYc65D1gCzjxVNW0=;
 b=OxpP8c5wQ+NO1puJ+OZ3+kmIRrEh1vH270bYc15OaLDoOaQKWNBwhCPZsahbXnl1NFzI
 BKPhXCuIBpN+DW1TvtlBTNO9ImcJcPflyywaTXpN3kwyy68v84/kAm/6dpVrqUI+TyZL
 vyDdUq7r/r5J4H3KmTBvKGD09nmkA03y5uffUDSBZgHvMqcXPCBtq71xd5kpZg2y+1No
 8B4z8GmwFTDI4dT0oTyfS6O851YFzkB9PjRLpLI0mFXjN+UqeQuMpPnsni4WexxNsFi5
 6x1SCw3cT1U7nQ+FV6y9tUZYAwpeEv0AUBxCGsNUVp1eUgYOMCh3Ee6OGnBHJETGdV3z AQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyry62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 18:33:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 268ILYYU040084;
        Fri, 8 Jul 2022 18:33:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud76dsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 18:33:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/wgzEXoovCbO0qks9syXLlB1BVZfLSQU5zsEtQa35SYpXsXGFYTzTiEv99Bs1uR1GDZC7lX32oGRp88omgdbLOEF5mzA4GOMe1XzIg3DrDUIYAura7TAHi/pvWM7FeCY9+A5FaAbo88NAO1E+lMxSpAesazK1xxR3O79H2OAeGI2vJcdOowN2u++2FxlLUfmECCIxqSHVIGoHZ2HtCDqd8qCTfkFj1isSb8CBcrvgaPGOXmbbeupxJrjOE+aWlNm0jrZK+Runo3UJ9P/P6lrq83Qr5pZAHiSgJJrDXLKkNKQrsgT+dac/fQAwwhGlewCuyY3fuWF/uS9RMnpx2fXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEx72V+vsxuBYnUTwHUJqyeyQSfBYc65D1gCzjxVNW0=;
 b=mzReB48vN6rlTETZbc1y4dH0SDmulSvruAOPYk6CPTr+mzOBIeuLY4ANjZGx2CFXT28ee5JgAIRAuiLe9ddDknQgeoBa2bMRPNPsJeC39lio94MC2ze/Du5tMeNQVwjybvvVZ0gT3mWG7hn8dg8V5O60BQM8uInPkdIPwcp9BX2ZFDvaY7cMtZx10dWIoJSy0aHU69aHQVf7Y5L1j2iI5HiLwhXXgMxeOJ4Sw0Dp1ADqwKZE+sv0jCbCdpZx4XdyubkZwO8TsbNM/DygQz2XbITOTqtNWLgYdAP2QXA/KnNPmxEYY1+DWCBPYqKMpFdwFKBNrjW3ak4J1OZWZus1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEx72V+vsxuBYnUTwHUJqyeyQSfBYc65D1gCzjxVNW0=;
 b=WhUdDE6bJs1BXYyr8PI6f/Xfj+e1Agu5JXUluMw8mXRZv+uvJ7J2FCwolgLNoVl0Bc4Qim0UNEmSf9HSv06wZ3wyPE/DrEPXSp28PKaaJS1w+++oqgeV5cLla0mlQuNvMFgGbmC8PtvNYZVYv8mk/+YB241D0UllvVgwiw89q90=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DM4PR10MB5919.namprd10.prod.outlook.com (2603:10b6:8:aa::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Fri, 8 Jul 2022 18:33:46 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::287e:5ffc:d595:8316]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::287e:5ffc:d595:8316%6]) with mapi id 15.20.5395.020; Fri, 8 Jul 2022
 18:33:46 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>, david.faust@oracle.com
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
        <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
        <87wncnd5dd.fsf@oracle.com>
Date:   Fri, 08 Jul 2022 20:33:38 +0200
In-Reply-To: <87wncnd5dd.fsf@oracle.com> (Jose E. Marchesi's message of "Fri,
        08 Jul 2022 16:51:58 +0200")
Message-ID: <8735fbcv3x.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0655.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::9) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f157e851-ca3a-4fe0-2d3f-08da61106482
X-MS-TrafficTypeDiagnostic: DM4PR10MB5919:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9NSgfh6hb1Vncz0FIGJbLK0e3koN29V1bc0fRL+MmgdVfmmFqB3llS2xJD2/iiLlmrFTPCMY0ySHIGkWONXPJjRcM4kk1asSPSfeeS7EJ9N7k0SfYE/2btlF1J1HqaxoiPKV62fa7hi2v+yq41VNgq/t64heb1dK5tehVIXLKuxR2CjB06cOEVOOT32if2buW6gncQHrqSpv1Pgz6a1RGB0PCyxEoaCwqfkD5VqANMycHBenLHjKjDNKy0pGW+bZaKUYebKSqK3DJBwpXs/llUxvp2laXCWD5IJSvZ/fZi/W5iH76KzoyrdZB17j5ABV+emBB0Xz5T5qe1eYyEglVK/LO2MEme2K8uU3y497m7TGvtvYAOu8dIHl81U0nehUclyjqf5YXy4JRtzlM3jN83Sm9qh0JWTq7dj0BntZhttejaK6Ta2T0rO/+b50JqeWkmVWwLbbciTCVqVeA+p9cPn4P7WjRuvTymWA9ZVWYzEYmqhqW2mgI7hIhY1O8O2tLjfQPDon3+2xzttdfP1p2JWw6D70fZncxZbVVEPP/F0zFo8idOrI30J+uInMQQkri8EySkPyx9Y6cQ9gHlRC0SHwlJZ7NA1jWwBJZuV+Ju8/j+1oeMyrwD7XzvQkH6K34Nl8CNK3wgSIWc3IeXp/xyB4twW0L+B1iqE0knaIs+YNCdPWaRM+8VZQY5kMTeFW+FgGelPGFvEJhdP5pBTgjrSzrX6tUDyx/fX0uaO8/4HKrNP2rTws9gsqQRpOrEP4WP8fnyMR1UI7LXfXa1aXK9KY4GT3VR1VoVlupVTov23tVLmCF7VOclCwt97SM+bz/CxemzEU50HWg1bWZbrczmfTtwr2JLHiS7wS1QiqJ3toQLMHuuw7vZTkAWbnU2Ol
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(39860400002)(396003)(186003)(107886003)(38100700002)(53546011)(2616005)(6506007)(52116002)(6512007)(26005)(6666004)(478600001)(41300700001)(38350700002)(5660300002)(8936002)(36756003)(2906002)(54906003)(316002)(6916009)(66946007)(66556008)(86362001)(966005)(8676002)(66476007)(6486002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TMNUDlWF7kW/dt0gM4hTxj9BXGzvXDZn7J46eF6ulxYmgugiL2JSvjcFEmaY?=
 =?us-ascii?Q?y7YN7jLJw2GrbBw+MCv+eCdWYe70Gdwb8HGmy7ezrlQ47QuNYLS09sBmiXyW?=
 =?us-ascii?Q?PHRSbnL3oIAtysaBZWhDQtFfz1+Zk7+E/nRoB4V0gETgbA0hwLL0tuqeP0GT?=
 =?us-ascii?Q?WerYIPJaBP4R5KK+/BLi9YOWJquZY5CUz1M09GB/MlGh+CPrcmqUzVPf81bc?=
 =?us-ascii?Q?+tKhxxSO99OBDTC7J69EYIgfTrJuJNe80tSIFjR2Rg7lMauTV914zMNLJHPb?=
 =?us-ascii?Q?63V9/83kOn+g9pokoGl716BWyZ0+CatTfZQrvMPNtCnbx1glP9CU5FGgCEyl?=
 =?us-ascii?Q?C/kHaMMw9dpAtSkhInIqXp3b+c0jhb0I22qz8NcEd/GK5EGE6ZqYTymn03aK?=
 =?us-ascii?Q?kEiVuSQ1yXtv4Mni5r2U6wV7/tz0ypozaalfszK+6R+bLyRQtayG38gpUMNo?=
 =?us-ascii?Q?CQTUXPz63y83kmUT5ilU4CyweRSsnRjZHqYau/3L1KQUYg8TbYA0goV7fdl/?=
 =?us-ascii?Q?k/fP/dsh/3kzFsVHIHnFIwaH4lf5T7Lhggxy6PbCTY3pSLsgScMFMrwaNUEp?=
 =?us-ascii?Q?FF5kTGQoux0Q0kqhDWS9KIfiG9b+CKdp3ba0wtO4LbrgurhS0bAifLrg2731?=
 =?us-ascii?Q?8MVRf4ucbYtdIwL06cr3VgucXKxNMkuHd85fQuNMOWIpMQj54KP4Gsq7qok7?=
 =?us-ascii?Q?wDEmzJ3Jzh+v+ELcwQ6HYRQ66NvUAbjlHSt4jT3vRp/K0sSsDDtLCQMddzqu?=
 =?us-ascii?Q?UOxsVGJoNIrRgJ6/XrXCHHKS1Hc9kHHDVGcegzQmipURJNWaq5KzvykqIFux?=
 =?us-ascii?Q?Sg+DqXZh9I7AHVFds62ZdbRDZZCQIgavjePn5ZtiM0ddu8SerNb0DcaRRqVq?=
 =?us-ascii?Q?Od/MGp8KhZFPeoiNpWiaa/5rqR0hM1RpJKH37pwN/i3sbtbJ8f3vJnVGAInr?=
 =?us-ascii?Q?JNRC6IRXUfVMwdXkjlw2poM//yNBIqpSsNWW76ZVbK8905N6HRlUZeknP3hE?=
 =?us-ascii?Q?gmAWn1/0PqYHCEOJiJQOZl0sVFAupfued9M/9Gg4PuekSiC9AC33zDHAOP9V?=
 =?us-ascii?Q?/LOjHTr3qJXFdHNoKMbOYTQWcPZTfiuUYihKayCjdiFumXRyg69V71E+SHQn?=
 =?us-ascii?Q?DEPv/A93UpyA9YRj7gr+IEOeqm3QKe2woQM33V6xDr20dj3LW6S7bZnYYJVJ?=
 =?us-ascii?Q?szQSlxdLfU4sJ3Qp28wffKfhaTw6hF0nvn9fDNL+9n5nIn8muGx2zDZtdfBi?=
 =?us-ascii?Q?NOvQwK11Hy08G80D7mjkcWYAYC0CQ7bitVhDGCVPrTiFziZxbnE8Xhlv4x8a?=
 =?us-ascii?Q?FX/CIf6MI+DcdSgJVToRaXLzl+BcQcfpDjI1yB98T5xPzPs2l4RKxig4mBoq?=
 =?us-ascii?Q?kUaAofRJzkEWHXk4/ENMPQFmE2u3en1Ki7mlO2UXFDSqDHlUzOjyZ9CAPzQK?=
 =?us-ascii?Q?Nor8qIRgCzUWfxDOwBuBEFc2zI7Nw1Oo3dmNKA525HhuUFGZJl1+xQ3po4XK?=
 =?us-ascii?Q?qGsEYM8l+s4fVU5eYzfivH7n4Uf7wgx1tGrjMeN7s9pWJemGx74O8xwxfsNX?=
 =?us-ascii?Q?HRGYUs4JcvIMwWEiJ9ELi5e/zphHX45aNOZMSMBy7knV7hZMvn3MKEeiZCDL?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f157e851-ca3a-4fe0-2d3f-08da61106482
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 18:33:46.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSfLQ0uFIWTYLxKdv01EYXLSUNbbWjvg9qj4FHunGNridMMwlvWH4O6OdlCPg9xbCIS6AXWde7nD8E5QuSDuGi31AVew2vN0vZ0DeDw9lWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5919
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-08_15:2022-07-08,2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080071
X-Proofpoint-GUID: iXow27OnRSTqXfCdZoJoGmtrPvqjlT1F
X-Proofpoint-ORIG-GUID: iXow27OnRSTqXfCdZoJoGmtrPvqjlT1F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> On Wed, Jul 6, 2022 at 10:13 AM James Hilliard
>> <james.hilliard1@gmail.com> wrote:
>>>
>>> Note I'm testing with the following patches:
>>> https://lore.kernel.org/bpf/20220706111839.1247911-1-james.hilliard1@gmail.com/
>>> https://lore.kernel.org/bpf/20220706140623.2917858-1-james.hilliard1@gmail.com/
>>>
>>> It would appear there's some compatibility issues with bpftool gen and
>>> GCC, not sure what side though is wrong here:
>>> /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>>> gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>>> src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
>>> libbpf: failed to find BTF info for global/extern symbol 'sd_restrictif_i'
>>> Error: failed to link
>>> 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
>>> Unknown error -2 (-2)
>>>
>>> Relevant difference seems to be this:
>>> GCC:
>>> [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
>>> Clang:
>>> [27] FUNC 'sd_restrictif_i' type_id=26 linkage=global
>
> For functions GCC generates a BTF_KIND_FUNC entry, which has no linkage
> information, or so we thought: I just looked at bpftool/btf.c and I
> found the linkage info for function types is expected to be encoded in
> the vlen field of BTF_KIND_FUNC entries (why not adding a btf_func
> instead???) which is surprising to say the least.
>
> We are changing GCC to encode the linkage info in vlen for these types.
> Thanks for reporting this.

Patch sent to GCC upstream:
https://gcc.gnu.org/pipermail/gcc-patches/2022-July/598090.html

>> GCC is wrong, clearly. This function is global ([0]) and libbpf
>> expects it to be marked as such in BTF.
>>
>> https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.c#L42-L50
>>
>>
>>> GCC:
>>>
>>> [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>>> [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
>>> [3] TYPEDEF '__u8' type_id=2
>>> [4] CONST '(anon)' type_id=3
>>
>> [...]
