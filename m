Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C8456BC3D
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbiGHOju (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 10:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbiGHOjn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 10:39:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597C013F0D
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 07:39:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268EUAME026567;
        Fri, 8 Jul 2022 14:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=2BrI6eeOPtyqKJhDkHNZcc9kmgNebukEX88xbcw4U/k=;
 b=RitLr6u/GoICfmh78T+6g8Bj+MIi+g7rLnmunlFaooqoi+UKgseP15INxEJ7BFYCJgPO
 mFShPA/Sizg+ecbsRzh4d5LBh05mzlVys7yKZCUasURYCIVSth7HBL7ZdwQ8a38JOOdI
 oulx5P0DvfC7J1rQM3vSrcAk6egOodR2K42eFe4QZVDkYakZRnM9UullhwToPUZCZNeT
 AE5wFASsMNh6G0e32jLfgqzpCwOkF9mStQh3KAbND4RHQT2TvYXHn4FNkyULpj23Joka
 n0kHU83wRzEYDoK41wH3T/5g59V0pRspKnIOaDIv/EZ4RAmjP0nYGGowrPbySed0RvP1 aQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubygb5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 14:39:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 268EWEUR016545;
        Fri, 8 Jul 2022 14:39:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4uda0ua4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 14:39:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2FsBXGUJ07BRfgWlAXwllfZfBcF9Pd7kOQQRTcmmJk7Qh5LX8bQ/phAUJ66hPbFg1/sJiovr+7iuuolvJTu+0xTdyPAs3wb4ePf/FkOdzNVZ40vuJI1tCj6ob8qjyeKiKAc4Ccfvcf8PsXu/h3zaI4Xr04lZPQL3s08DjFkNBuJcbecgB5QCzlzkYnCTgU7oVOVlPcg5endab6ExoMq13dq8ey12rPPnb8lslT1Gh57OrvS3a6HRqjV+NjfF0pT5Y42B3TWVXJTuEIfg3+NPuDVwB14wIuKdAJjVrHmX4qcqQ0YssTGih3YdF/glAWXZpeQNl6dtwrVt1PQQ+VZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BrI6eeOPtyqKJhDkHNZcc9kmgNebukEX88xbcw4U/k=;
 b=CDQcinGfsuVvc8XfKj04994J12mk6niREL5qNdfh8HSap26l2wPWGbtGIg2/WRvrufLMnAD3ckueRqiD/puihE7umZDk6Ym4JDKfxpSsy89+XJ6pP2hQtVQZh7cIgI8wjwrD16CTalqzSO7ds8zNHB0Q8hrRZcUwbOoPW21PxrBsE/3swK46ZjHYURQxHG95grwddKJ4oxo/9mKqz3nq69D0Lt6JmZiqFEqSZD/VVTsgAe/KAAePjw9WGL1KfdFOvGtUHGQ9H+yj0RwlN7o6rph9PLDuVK7HdE084eHgv14+pu3kIjnEIG5O1r7cUfUKzUfa2/uflRKuRum+si7AOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BrI6eeOPtyqKJhDkHNZcc9kmgNebukEX88xbcw4U/k=;
 b=eo8y3p1BtFIeW5yvEMYjVeqrZia/+SYGgTdLUjgve1NNqSRGApqHuAKy5nwVVZMYdsArfG/s03PX2AQg7a9Mgb2+X5P0dyhViokd4fZpYX5TqpwuaV1FPLLQ5h/oxTboUWpXpjAEstbZyc9RikfTn5yjpFKfz9XIAoJE9SlwuUs=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BN8PR10MB3731.namprd10.prod.outlook.com (2603:10b6:408:b7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Fri, 8 Jul
 2022 14:39:37 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::287e:5ffc:d595:8316]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::287e:5ffc:d595:8316%6]) with mapi id 15.20.5395.020; Fri, 8 Jul 2022
 14:39:37 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
        <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
        <CADvTj4rfDAFj0MAVyo=jaBG85MTgHcXi75_cRsby1LXTk7FgfQ@mail.gmail.com>
        <87let3es35.fsf@oracle.com>
        <CADvTj4qZANp7CxJnM_AoFcvRQpnXC0nmTagNgnnzkGMSLKeH+A@mail.gmail.com>
        <875yk7emz3.fsf@oracle.com>
        <CADvTj4oCE4Q+4=oCrFoX1fuq7xXnHZsVJ3=rkOF8n8+6wkYXzw@mail.gmail.com>
Date:   Fri, 08 Jul 2022 16:39:29 +0200
In-Reply-To: <CADvTj4oCE4Q+4=oCrFoX1fuq7xXnHZsVJ3=rkOF8n8+6wkYXzw@mail.gmail.com>
        (James Hilliard's message of "Fri, 8 Jul 2022 07:53:46 -0600")
Message-ID: <871quvekim.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0019.eurprd07.prod.outlook.com
 (2603:10a6:205:1::32) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 811b584c-76e9-4b5f-bcae-08da60efaeb3
X-MS-TrafficTypeDiagnostic: BN8PR10MB3731:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rC3K3NoZ9SCqU52Fye2t5PFU/goCQhdfCiFNipL80hbMYCH+sXv+NISzUpfMSuOEGwzTDYPe8x//iEEytuW960Y/nV/GedB1oXtVArLoxsztEkHXbFmVO6rExNh5INAym9HZ9B/Nf5HZZRwMasRRnRw3HyX+6bRnvS9LpsNgqXr1YaVfrZdQ4SLMO1r9azel0zXFRgOMrxPNrSZPhModIcb0JnbJF3fMwyb7VEk2xTOzel6BAe8GXXsTS7KiigDZbTgzdBLOfGTO2mM3Ye5Npeh2+uVCT8EWrXBCkom8CWVOhh0FgXK1EdUIL2/jB8Udo6YU2c10JA9v9jPrVx5qv4+uU+eNTuO9KMYfyKMj0ONQLGvveATgnzN+TbrK12C7fBajH7+MCSRBA4qvvgVb/Gq8qWudX09SicUVrOrZUPqn4DO0eo15xHLJ6dNcGcMkA0LA498IHgp0vT6WzB2wOyqnXY12rSQ5qtYtWq4eUPlgaNvp6R9gJDIa4ccKuP+fE8GJz6SrCvPR4xKIBTrnht16VKs8FMVXUDlS8uu46izS7tBdqUIJ1AI/Md25AF7PSXtSdUV2gD/Csb8Yd+51Ol9dDT6WugOgAM4d3g+e8F4ZmspuXhc5hGchJEkP0O798J3n65mzfVsOH04G+lZuUGCjvnORGocV4RY2Tff3cvmb8yHs1VDCWMUxAmQbIUywv+3vnK1UBGDUlQFKBhdp6E9y4+tP+pLPd2uypA/M//YYrIroM3GxjlfT10483dTv4pazWjT+ufV6z1v67FSsYyd7tUZ2wdGCtcvhvyA35IFmRD0bLAPa3vepcG4ObV1XMpBLOOvocjr67Ax575U7QUNzkr+5jsgYbiVKVISXZnpfG55+YW6N7OYWTt6PIX0f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(346002)(376002)(136003)(38100700002)(4326008)(66556008)(8936002)(86362001)(5660300002)(8676002)(2906002)(66476007)(66946007)(41300700001)(38350700002)(186003)(6666004)(6512007)(30864003)(316002)(6506007)(52116002)(53546011)(2616005)(6916009)(6486002)(478600001)(54906003)(36756003)(26005)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3U4/PTYAveqTOppnahP4b1f+uKvOsSgsUE6M824PsvXnta//XwKcx2/V5u6o?=
 =?us-ascii?Q?Y57XC28P4ScBzTPWywBdoHtNqe6siwsRExIMUfwLembLi0a/Ad+hwrybym0R?=
 =?us-ascii?Q?jBq8a9HB/GFJHwnqR70BwyEwG8ioAsMsQGQdk3E+FZjCeBiMSKcxJCkjtMmd?=
 =?us-ascii?Q?J4Fh0u3nyWeKNyjM7g8cN6yH7QFAxQtxk9RF9DwBr3x12AZPhLyxer4Vedtw?=
 =?us-ascii?Q?Hoo8jL1WpJCFaqRycUo8AzEzw3ZEEzaGZJEtHBnzK5B2Z9gOD4GeZZ3IRO2y?=
 =?us-ascii?Q?BZ5LSMhOHx2X5M6PjNMYlQn0NDVQ9MLhYTH1s0/blUZhmfwQiO5KkAL4REBE?=
 =?us-ascii?Q?KezbFSBsUKDbl4wWqUPB9eWO+xxwsWnNwQ3vNU5+wzXwRP3YHPCLIXfJgMJp?=
 =?us-ascii?Q?Hdmmu6Na6SWKOhYXn+bRXsVF6EyS/nXVlcJgnZznvW6mVROFM3qsP5eDq0nA?=
 =?us-ascii?Q?yD7nXrpkBaRfGbs58wt0lKJPEsjmtNbxQBpQM7BMaLCxemfZqug/mSuobKx3?=
 =?us-ascii?Q?hNeQeQ7+XM7Pw+heGZZ/8Nw1yx6IrCsg5a/xOeG1hXwVRJ7LKOvsnCGfQB9W?=
 =?us-ascii?Q?EuSfqISvxziZL7kQ4AYYEUTdsUTuAThrUP7PD1+67OCxtTniXVnNw80ogpwh?=
 =?us-ascii?Q?QybStTVzKE8ijitzt9cWuQNbfbGfnlo16SwZyuHICx1THWNsJMQdUScStGZj?=
 =?us-ascii?Q?atBuY1mYahx5F5Ph1w/5CfXfDI6XrM+JIjula/YNXf4I4vbqpVOmcOUFPWwW?=
 =?us-ascii?Q?cwo4EGyFZ+wKmPJdCCktfX7g1VeTU0GUBDt+p3ZsRZa6h+A6z30yU7KSHrMI?=
 =?us-ascii?Q?vjjc1ET2sd33USZtAANwoaiq/2WSlQN3+uLQ5lY+X+3iPkA3PJfps6HQehb2?=
 =?us-ascii?Q?GB6Y+J7hgLAvoV73MwtT0M6NqSC4P1aRe3Q0feqIHOMScR7moAiMeG0LE2xz?=
 =?us-ascii?Q?D1d2jW6MEjr4HL8HKmlAkZXolH5EbLW9dNBNxtUCaWidZ5h2XOibMvSawa+/?=
 =?us-ascii?Q?2Y1NTZfS2hcBOUk43C5ylGZW1A2odFTCVCaNoI5fNZEbVYEhC7kEvDzVXf0h?=
 =?us-ascii?Q?7jJ1YZ6s/A7NmkZU2YSBxn1zTsuvgJEHKjy5bs3evlW1D/Yfa/ETTKR+M/2k?=
 =?us-ascii?Q?4csbo/lXSr9C+ZulG0va9n8k+JmgSuXPohC01nyXpLH+l+UOyHFJ+11SJyo/?=
 =?us-ascii?Q?s8bfKhR/FZTuzdOYhHeJtwY38/ID86IZWV9McRSNSUhyKayBygLX20p81d9/?=
 =?us-ascii?Q?FtcTtDCckM2hlvFJ2RjRhsTr/cJe96aYBzW1+/EwRgpbmTkmHa49aDV9OJzf?=
 =?us-ascii?Q?cKeh3oPSvTkZAAxNCkKLUIsnRP+plzH6jywbEshKM+1EDe3PM6I6lweDKCDa?=
 =?us-ascii?Q?vtxbXx6h0aMZ169K9UDiqFZ8a/YPC/TvFqn1DJRSKAwzhk+wUnkpvlqfqaJt?=
 =?us-ascii?Q?71uZwMT0J+09tjBldbox+nl6xUEbD4tu5ZU4HdHq4E6jbeIJ8SKInupCzQJI?=
 =?us-ascii?Q?iFpfuXvcKakIA16NRwf3TQ2a1pcPBv7SG9JTuYRK8nc9tZemVDDj3HrRiPP5?=
 =?us-ascii?Q?xVahXV0hE5vKj5ar4ThMWUVGPpfBP9Ysck3EqY/t61aTYH7PaNG+qxhyNNFz?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811b584c-76e9-4b5f-bcae-08da60efaeb3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 14:39:37.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZIpn/3unJGSejWdnBkXdMCN9aLuMWfx7KhEjWjC2GxdEyu0gsVQZQgrrReZIgJAQswjm7emx+NKsqwSoR3Aw+8SQSlWd5Hss8QmwehVX38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3731
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-08_12:2022-07-08,2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080056
X-Proofpoint-ORIG-GUID: dODnQNjfPDO59LFzgoD_0qeg_kzJxxHV
X-Proofpoint-GUID: dODnQNjfPDO59LFzgoD_0qeg_kzJxxHV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Fri, Jul 8, 2022 at 7:46 AM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On Fri, Jul 8, 2022 at 5:56 AM Jose E. Marchesi
>> > <jose.marchesi@oracle.com> wrote:
>> >>
>> >>
>> >> > On Wed, Jul 6, 2022 at 11:20 AM Andrii Nakryiko
>> >> > <andrii.nakryiko@gmail.com> wrote:
>> >> >>
>> >> >> On Wed, Jul 6, 2022 at 10:13 AM James Hilliard
>> >> >> <james.hilliard1@gmail.com> wrote:
>> >> >> >
>> >> >> > Note I'm testing with the following patches:
>> >> >> > https://lore.kernel.org/bpf/20220706111839.1247911-1-james.hilliard1@gmail.com/
>> >> >> > https://lore.kernel.org/bpf/20220706140623.2917858-1-james.hilliard1@gmail.com/
>> >> >> >
>> >> >> > It would appear there's some compatibility issues with bpftool gen and
>> >> >> > GCC, not sure what side though is wrong here:
>> >> >> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> >> >> > gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> >> >> > src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
>> >> >> > libbpf: failed to find BTF info for global/extern symbol 'sd_restrictif_i'
>> >> >> > Error: failed to link
>> >> >> > 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
>> >> >> > Unknown error -2 (-2)
>> >> >> >
>> >> >> > Relevant difference seems to be this:
>> >> >> > GCC:
>> >> >> > [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
>> >> >> > Clang:
>> >> >> > [27] FUNC 'sd_restrictif_i' type_id=26 linkage=global
>> >> >> >
>> >> >>
>> >> >> GCC is wrong, clearly. This function is global ([0]) and libbpf
>> >> >> expects it to be marked as such in BTF.
>> >> >
>> >> > Does this invocation look correct?
>> >> > /home/buildroot/buildroot/output/per-package/systemd/host/bin/bpf-gcc
>> >> > -O2 -mkernel=5.2 -mcpu=v3 -mco-re -gbtf -r -std=gnu11 -D__x86_64__
>> >> > -mlittle-endian -I. -idirafter
>> >> > /home/buildroot/buildroot/output/per-package/systemd/host/x86_64-buildroot-linux-gnu/sysroot/usr/include
>> >> > ../src/core/bpf/restrict_fs/restrict-fs.bpf.c -o
>> >> > src/core/bpf/restrict_fs/restrict-fs.bpf.unstripped.o
>> >>
>> >> Hmm, why linking a relocatable ELF instead of just using a compiled
>> >> object (with -c)?
>> >
>> > This bpftool gen object build stage AFAIU is needed to strip the object before
>> > using it for skeleton generation, does that sound right?
>>
>> Thing is, `gcc -r' involves the linker.  The GNU linker (ld) supports
>> linking BPF objects, but AFAIK the kernel BPF objects are all supposed
>> to be compiled objects, not linked as relocatable objects.  (The LLVM
>> BPF toolchain doesn't support linking BPF objects as far as I know.)
>
> Maybe bpftool needs support for a different ELF file kind?
>
> When I omit the '-r' flag I get this error from bpftool:
> libbpf: unsupported kind of ELF file

Yes, because if you omit -r you are basically linking an ELF executable,
which libbpf doesn't support.

If you instead replace -r with -c, you will get a plain object file.

>>
>> That's my understanding, but note I'm not very familiar with bpftool
>> (I'm trying to find time now to fix that.)
>>
>> >>
>> >> > I've also tried without the -r(relocatable object) flag but that gives
>> >> > a different error:
>> >> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> >> > gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> >> > src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
>> >> > libbpf: unsupported kind of ELF file
>> >> > src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o: no
>> >> > error
>> >> > Error: failed to link
>> >> > 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
>> >> > Unknown error -95 (-95)
>> >> >
>> >> > GCC without relocatable flag:
>> >> > [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> >> > [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
>> >> > [3] TYPEDEF '__u8' type_id=2
>> >> > [4] CONST '(anon)' type_id=3
>> >> > [5] VOLATILE '(anon)' type_id=4
>> >> > [6] INT 'short int' size=2 bits_offset=0 nr_bits=16 encoding=SIGNED
>> >> > [7] INT 'short unsigned int' size=2 bits_offset=0 nr_bits=16 encoding=(none)
>> >> > [8] TYPEDEF '__u16' type_id=7
>> >> > [9] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>> >> > [10] TYPEDEF '__s32' type_id=9
>> >> > [11] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>> >> > [12] TYPEDEF '__u32' type_id=11
>> >> > [13] INT 'long long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
>> >> > [14] INT 'long long unsigned int' size=8 bits_offset=0 nr_bits=64
>> >> > encoding=(none)
>> >> > [15] TYPEDEF '__u64' type_id=14
>> >> > [16] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
>> >> > [17] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
>> >> > [18] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> >> > [19] CONST '(anon)' type_id=18
>> >> > [20] TYPEDEF '__be16' type_id=8
>> >> > [21] TYPEDEF '__be32' type_id=12
>> >> > [22] ENUM 'bpf_map_type' encoding=UNSIGNED size=4 vlen=31
>> >> >     'BPF_MAP_TYPE_UNSPEC' val=0
>> >> >     'BPF_MAP_TYPE_HASH' val=1
>> >> >     'BPF_MAP_TYPE_ARRAY' val=2
>> >> >     'BPF_MAP_TYPE_PROG_ARRAY' val=3
>> >> >     'BPF_MAP_TYPE_PERF_EVENT_ARRAY' val=4
>> >> >     'BPF_MAP_TYPE_PERCPU_HASH' val=5
>> >> >     'BPF_MAP_TYPE_PERCPU_ARRAY' val=6
>> >> >     'BPF_MAP_TYPE_STACK_TRACE' val=7
>> >> >     'BPF_MAP_TYPE_CGROUP_ARRAY' val=8
>> >> >     'BPF_MAP_TYPE_LRU_HASH' val=9
>> >> >     'BPF_MAP_TYPE_LRU_PERCPU_HASH' val=10
>> >> >     'BPF_MAP_TYPE_LPM_TRIE' val=11
>> >> >     'BPF_MAP_TYPE_ARRAY_OF_MAPS' val=12
>> >> >     'BPF_MAP_TYPE_HASH_OF_MAPS' val=13
>> >> >     'BPF_MAP_TYPE_DEVMAP' val=14
>> >> >     'BPF_MAP_TYPE_SOCKMAP' val=15
>> >> >     'BPF_MAP_TYPE_CPUMAP' val=16
>> >> >     'BPF_MAP_TYPE_XSKMAP' val=17
>> >> >     'BPF_MAP_TYPE_SOCKHASH' val=18
>> >> >     'BPF_MAP_TYPE_CGROUP_STORAGE' val=19
>> >> >     'BPF_MAP_TYPE_REUSEPORT_SOCKARRAY' val=20
>> >> >     'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE' val=21
>> >> >     'BPF_MAP_TYPE_QUEUE' val=22
>> >> >     'BPF_MAP_TYPE_STACK' val=23
>> >> >     'BPF_MAP_TYPE_SK_STORAGE' val=24
>> >> >     'BPF_MAP_TYPE_DEVMAP_HASH' val=25
>> >> >     'BPF_MAP_TYPE_STRUCT_OPS' val=26
>> >> >     'BPF_MAP_TYPE_RINGBUF' val=27
>> >> >     'BPF_MAP_TYPE_INODE_STORAGE' val=28
>> >> >     'BPF_MAP_TYPE_TASK_STORAGE' val=29
>> >> >     'BPF_MAP_TYPE_BLOOM_FILTER' val=30
>> >> > [23] UNION '(anon)' size=8 vlen=1
>> >> >     'flow_keys' type_id=29 bits_offset=0
>> >> > [24] STRUCT 'bpf_flow_keys' size=56 vlen=13
>> >> >     'nhoff' type_id=8 bits_offset=0
>> >> >     'thoff' type_id=8 bits_offset=16
>> >> >     'addr_proto' type_id=8 bits_offset=32
>> >> >     'is_frag' type_id=3 bits_offset=48
>> >> >     'is_first_frag' type_id=3 bits_offset=56
>> >> >     'is_encap' type_id=3 bits_offset=64
>> >> >     'ip_proto' type_id=3 bits_offset=72
>> >> >     'n_proto' type_id=20 bits_offset=80
>> >> >     'sport' type_id=20 bits_offset=96
>> >> >     'dport' type_id=20 bits_offset=112
>> >> >     '(anon)' type_id=25 bits_offset=128
>> >> >     'flags' type_id=12 bits_offset=384
>> >> >     'flow_label' type_id=21 bits_offset=416
>> >> > [25] UNION '(anon)' size=32 vlen=2
>> >> >     '(anon)' type_id=26 bits_offset=0
>> >> >     '(anon)' type_id=27 bits_offset=0
>> >> > [26] STRUCT '(anon)' size=8 vlen=2
>> >> >     'ipv4_src' type_id=21 bits_offset=0
>> >> >     'ipv4_dst' type_id=21 bits_offset=32
>> >> > [27] STRUCT '(anon)' size=32 vlen=2
>> >> >     'ipv6_src' type_id=28 bits_offset=0
>> >> >     'ipv6_dst' type_id=28 bits_offset=128
>> >> > [28] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=4
>> >> > [29] PTR '(anon)' type_id=24
>> >> > [30] UNION '(anon)' size=8 vlen=1
>> >> >     'sk' type_id=32 bits_offset=0
>> >> > [31] STRUCT 'bpf_sock' size=80 vlen=14
>> >> >     'bound_dev_if' type_id=12 bits_offset=0
>> >> >     'family' type_id=12 bits_offset=32
>> >> >     'type' type_id=12 bits_offset=64
>> >> >     'protocol' type_id=12 bits_offset=96
>> >> >     'mark' type_id=12 bits_offset=128
>> >> >     'priority' type_id=12 bits_offset=160
>> >> >     'src_ip4' type_id=12 bits_offset=192
>> >> >     'src_ip6' type_id=28 bits_offset=224
>> >> >     'src_port' type_id=12 bits_offset=352
>> >> >     'dst_port' type_id=20 bits_offset=384
>> >> >     'dst_ip4' type_id=12 bits_offset=416
>> >> >     'dst_ip6' type_id=28 bits_offset=448
>> >> >     'state' type_id=12 bits_offset=576
>> >> >     'rx_queue_mapping' type_id=10 bits_offset=608
>> >> > [32] PTR '(anon)' type_id=31
>> >> > [33] STRUCT '__sk_buff' size=192 vlen=33
>> >> >     'len' type_id=12 bits_offset=0
>> >> >     'pkt_type' type_id=12 bits_offset=32
>> >> >     'mark' type_id=12 bits_offset=64
>> >> >     'queue_mapping' type_id=12 bits_offset=96
>> >> >     'protocol' type_id=12 bits_offset=128
>> >> >     'vlan_present' type_id=12 bits_offset=160
>> >> >     'vlan_tci' type_id=12 bits_offset=192
>> >> >     'vlan_proto' type_id=12 bits_offset=224
>> >> >     'priority' type_id=12 bits_offset=256
>> >> >     'ingress_ifindex' type_id=12 bits_offset=288
>> >> >     'ifindex' type_id=12 bits_offset=320
>> >> >     'tc_index' type_id=12 bits_offset=352
>> >> >     'cb' type_id=34 bits_offset=384
>> >> >     'hash' type_id=12 bits_offset=544
>> >> >     'tc_classid' type_id=12 bits_offset=576
>> >> >     'data' type_id=12 bits_offset=608
>> >> >     'data_end' type_id=12 bits_offset=640
>> >> >     'napi_id' type_id=12 bits_offset=672
>> >> >     'family' type_id=12 bits_offset=704
>> >> >     'remote_ip4' type_id=12 bits_offset=736
>> >> >     'local_ip4' type_id=12 bits_offset=768
>> >> >     'remote_ip6' type_id=28 bits_offset=800
>> >> >     'local_ip6' type_id=28 bits_offset=928
>> >> >     'remote_port' type_id=12 bits_offset=1056
>> >> >     'local_port' type_id=12 bits_offset=1088
>> >> >     'data_meta' type_id=12 bits_offset=1120
>> >> >     '(anon)' type_id=23 bits_offset=1152
>> >> >     'tstamp' type_id=15 bits_offset=1216
>> >> >     'wire_len' type_id=12 bits_offset=1280
>> >> >     'gso_segs' type_id=12 bits_offset=1312
>> >> >     '(anon)' type_id=30 bits_offset=1344
>> >> >     'gso_size' type_id=12 bits_offset=1408
>> >> >     'hwtstamp' type_id=15 bits_offset=1472
>> >> > [34] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=5
>> >> > [35] CONST '(anon)' type_id=33
>> >> > [36] PTR '(anon)' type_id=0
>> >> > [37] STRUCT '(anon)' size=24 vlen=3
>> >> >     'type' type_id=39 bits_offset=0
>> >> >     'key' type_id=40 bits_offset=64
>> >> >     'value' type_id=41 bits_offset=128
>> >> > [38] ARRAY '(anon)' type_id=9 index_type_id=16 nr_elems=1
>> >> > [39] PTR '(anon)' type_id=38
>> >> > [40] PTR '(anon)' type_id=12
>> >> > [41] PTR '(anon)' type_id=3
>> >> > [42] ARRAY '(anon)' type_id=19 index_type_id=16 nr_elems=18
>> >> > [43] CONST '(anon)' type_id=42
>> >> > [44] FUNC_PROTO '(anon)' ret_type_id=36 vlen=2
>> >> >     '(anon)' type_id=36
>> >> >     '(anon)' type_id=46
>> >> > [45] CONST '(anon)' type_id=0
>> >> > [46] PTR '(anon)' type_id=45
>> >> > [47] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>> >> >     'sk' type_id=48
>> >> > [48] PTR '(anon)' type_id=35
>> >> > [49] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>> >> >     'sk' type_id=48
>> >> > [50] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>> >> >     'sk' type_id=48
>> >> > [51] VAR 'is_allow_list' type_id=5, linkage=global
>> >> > [52] VAR '_license' type_id=43, linkage=static
>> >> > [53] VAR 'sd_restrictif' type_id=37, linkage=global
>> >> > [54] FUNC 'bpf_map_lookup_elem' type_id=44 linkage=static
>> >> > [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
>> >> > [56] FUNC 'sd_restrictif_e' type_id=49 linkage=static
>> >> > [57] FUNC 'restrict_network_interfaces_impl' type_id=50 linkage=static
>> >> > [58] DATASEC 'license' size=0 vlen=1
>> >> >     type_id=52 offset=0 size=18 (VAR '_license')
>> >> > [59] DATASEC '.maps' size=0 vlen=1
>> >> >     type_id=53 offset=0 size=24 (VAR 'sd_restrictif')
>> >> > [60] DATASEC '.data' size=0 vlen=1
>> >> >     type_id=51 offset=0 size=1 (VAR 'is_allow_list')
>> >> >
>> >> >>
>> >> >> https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.c#L42-L50
>> >> >>
>> >> >>
>> >> >> > GCC:
>> >> >> >
>> >> >> > [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> >> >> > [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
>> >> >> > [3] TYPEDEF '__u8' type_id=2
>> >> >> > [4] CONST '(anon)' type_id=3
>> >> >>
>> >> >> [...]
