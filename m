Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7036914D9
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 00:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBIXqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 18:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjBIXqL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 18:46:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AED3C07
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 15:46:10 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319N4SqL024040;
        Thu, 9 Feb 2023 23:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=YWZpkRaOaSRJu3MhU4sApyJpRKX3mbdQilZhZWa3yVo=;
 b=LrnrsTAJb7KJEsIi+QhaN5NRGt5107J25p211CCrnn1LxL1oZU3pn4vb+r3YuZ6p33np
 hKQ9eONbkCFBvCmOnq9IjPoUHySmJCu9IwL9SBZ/UrRlTn5/9b0kRWHwG8jQmCF+zqzr
 vBFczO/Zsmws/t3qr5C87cGYpsx25SNk6r+GzN6qyRCI1gSx0b+YqoyPw1goUbzFTVR4
 wfPVZE6SEcnUzf4LaGaDlN2MASSEKg6FZrWBM/b8kh2JOuQWNmYulTqiwgqG7acIYr1t
 bv/YElLiuyCZcptdm9CbYJLiUt2Kq0wwPJC4sraanCWwF7ZLxOwWz1pmOlTjjHFLc0vh NA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfwuc3b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 23:45:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 319Nj4l9015270;
        Thu, 9 Feb 2023 23:45:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbe3qpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 23:45:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbeJOOIEWZxH5WJS5/1rMA0CKZ4OZV2HfnxWxBdlyGiy1qta3d2ZehBiT3HySMaTJkrBXzv7fvGGB2aRzyFBXFleUfmGu04Z/if4Jr1r4RToggHtmg5TRVHQ6k0WmrXMuquSygL60ZiaqgX4dqh2gauvc8S6rUr8b9HtEbHz/+aqn6+YTGCiIi0oIPQvV9FeWcsAD+gfKQg6xkn+fHVaB/rgY9Y4RGvn7a25cRHgWVAUL/SERj8JahN4VglSUV2oaPB6pDVUIUyhmzTIOCdsLM3lwYwVoMEyHs5owmKskZxnTyGIih1FwINkYL2ZFBg0fKbEmGA+khEHP7RnNQydAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWZpkRaOaSRJu3MhU4sApyJpRKX3mbdQilZhZWa3yVo=;
 b=OCBloEncMxtN8ngFKSDdf35PooizP6jU+WVLFFZGsSW9uzOkcBUcI0BQflLjcVvwlv3DNRVj6UYeUvKBAhVODvsnWNrQGa8Wnfryvj1wOsDYPXEUDFluf/DRdi/H7olL9MVCI82t5OAprBsbZCKDVkz3LH5dolf8EylToJpa2SJc8cGrWOgpDa3cKUJ8BR3rPyoBmwIrO6skyxBXFXK5Mpj25dLs3rvd04NDM/kUe84EUYT5KEX1mGXsM4jt3QBqKRIbLhHy8Hc99ndlggyp/Z0gp/5M2IBcVeq+NKm2vRFMYqdQaGDvRAl4L51TBUU8l0G4Oqb0L418ToEZy5t2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWZpkRaOaSRJu3MhU4sApyJpRKX3mbdQilZhZWa3yVo=;
 b=qmPyqYX+1EBUtGaIbZ9Hk02xXzGTSXmF6QAdB+bO2a/qVIi4xNgsnWmdFOBu4vBwTGIhW6Najn9gGScQzc7TQRppIi93fFNyiqulNo8wnmmkb8SUR4TzrHDbpFMgWt3g4RLqKpzm+mOdAjVIE+z+JWSZ6Dg8XqKK0uvyrYhx3rc=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by IA1PR10MB7144.namprd10.prod.outlook.com (2603:10b6:208:3f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18; Thu, 9 Feb
 2023 23:45:44 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85%7]) with mapi id 15.20.6086.011; Thu, 9 Feb 2023
 23:45:43 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Faust <david.faust@oracle.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>
Subject: Re: bpf: Propose some new instructions for -mcpu=v4
In-Reply-To: <87fsbe8l8n.fsf@oracle.com> (Jose E. Marchesi's message of "Fri,
        10 Feb 2023 00:36:24 +0100")
References: <01515302-c37d-2ee5-c950-2f556a4caad0@meta.com>
        <87fsbe8l8n.fsf@oracle.com>
Date:   Fri, 10 Feb 2023 00:45:36 +0100
Message-ID: <87bkm28ktb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0161.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::22) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|IA1PR10MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 01cee080-d6ae-4fa0-3258-08db0af7c224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZ3khjOZWzAf5pxiopjfPR5qbYTxCgZiwGhBLIQD7I1m8Vo0XItYQ/KQOQkrKXl7zfEgktwFIkmYyY0/aoYAHlcCJqHfWBTbUdXgwgK1XKTJOw8aK0iNvZeFsb+Lx19bag1u5UZrgGKyZdCU+xl3hbC4dl/aEVb4ES3fyWvT6M0K5B+Rf4o4ZxAKiMER9Qxad0J79B8E4LPAWgyFBmHdY3zFSV8Ez9t04mlJFQ5z66yyZUgjEaNOruKiGdYNadhiBhdzYxUrR9tuGKSDD/CdLwSIDpDJeZB1SAUfPQ5jbIbItS1By8tOE0CyUYn76bPhOKui4pRP4YiKSseWLDEY3oXSIwPAoW57FX5j2vqPDZ1saB06mAKCn3KI+6xm3jmP+TZDacfj2Tlx5JO/KyUMN+HyM7VdlTypPyKt7SP0ucyJrhEFU764hataZk+WLWRV9ULtuJt94Eq+2Yr9jMagQMZyt9cqBC8knYlE9Gp3X+VxSgQnKpTjtSlcvl7Ul3Csjz6cuLzKv9xfOdNHHn08TAvJ/+bP985kn+4jtgrNTGayuYdFBDKp+4So6moyO3mWSwbSM3qN6pr4rpyMEo/DVOlFNHyyJW81wIJwoQgVFZqHG9zts9jlhjnch/ahENKj19qJ5Xk0bVs/lYjr7KzAyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199018)(6512007)(38100700002)(8676002)(26005)(2616005)(186003)(83380400001)(66556008)(36756003)(6666004)(54906003)(316002)(4326008)(66476007)(478600001)(6486002)(6506007)(86362001)(558084003)(66946007)(6916009)(8936002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9y9N4FNBqyjkra980QKVAZTXalrRLG8s+iv6lmWuQA8PjhrB/nsT80z91wjU?=
 =?us-ascii?Q?21EmEwv/Yz9y50b3v5j1MQW8152WBu2kF4alP+6Ii6EPb59m5skmJZ+wwq7A?=
 =?us-ascii?Q?AHzM1jjU4HNBCD7SrdzTcYrcT7mIcNc+DgPH9sYFOTbNDmVjyDqwCIfxya72?=
 =?us-ascii?Q?AMqn0q8GgXYKrhpN9EmH0xTvZ1W3vVieRSFHgaXuK4VI7/8UovwRkbPbALfy?=
 =?us-ascii?Q?JmuNSyYp05MEWzwbXEgqSFaw0h4tCi0+927X6xxYrDNyyFdhAvc9Y8bq6xfN?=
 =?us-ascii?Q?Ux1YLVEBJN8jATBcl+aY4UUJagAoehRqKbfKyGXGg4eO4PLbNcWmfCFxk0Nt?=
 =?us-ascii?Q?onia0PCWGEbbnb/ZqlLhq4tftcPpZWsyXfDhOjhGXdSxtcZ/H+QNqdqIEnly?=
 =?us-ascii?Q?lAGYdxmfTY77u9+jYFcV+wsVfwdspR3V/C+92YuNzLeZASp6go08y9UmCsDM?=
 =?us-ascii?Q?k7r/RGm6oNSRc94eRPxuBrY6x3TAeO4rRPYpxNr3l9u0W+aIeLrS7h1KSM/g?=
 =?us-ascii?Q?ybNpVR9HdoI3yZW00/82+80i57R5RBC/kofOhqnCzXzDcDvcUQdh5CD0lX7k?=
 =?us-ascii?Q?gVKiqIlAl7Yk1RKjvZBXLEl3d4tiwwvpUla7jSPxubx8Cmdvr1U4a2DRafeJ?=
 =?us-ascii?Q?F4pAnJiMdSbKQipnQVRmYpSX+uoZO1HV63gWpBZhdFGfHPZxWzUdeUvPexX3?=
 =?us-ascii?Q?CIn4NSiRkNT9WWj94GJ4wiQ6SNxvizHY9NlehWvO6vGqk0HKm7ep9RbDI0jZ?=
 =?us-ascii?Q?N75XjaWpohll9ftapQk5DOm2yV3AhlMZ+8HBljMSRN1B4q5iI4xg9uagGwLr?=
 =?us-ascii?Q?2PsYAFZHqgstO9YKPyTSgKoG2dcOL5Lt7UWo9VfCRzlD8+oUJoy7M0kykkPl?=
 =?us-ascii?Q?dY7rg1M0XmkyntK6kvKnTld7FNz3NH9HJWMrGkpKQ0FKGSW1+uEPo2ERnaUC?=
 =?us-ascii?Q?/0L0x/6vQ9jDK+HhLzeoYVdcPfttWBO7pSU4DcMyHrKc28xeT6bnE4u2NZNO?=
 =?us-ascii?Q?3/oaWtGmAyZKEmYNXqdzrapES7LbbklSoz90ldIlhPS9RpuZN1HCqeqCHJit?=
 =?us-ascii?Q?bjcnHNAv7hw8qtWOB7fFpjom+vpAYHt385VjTN0KaFdHL5XR8dy406cfEHOp?=
 =?us-ascii?Q?6rdaZT6sj8Jt+K+L8/7/jxWnqzbGm8U8617J0eAZbnct+j5lcXBEvsIENXIq?=
 =?us-ascii?Q?4Z6WARAEYQQYIaFGeueMur3tfM4vsQM5P+ys+32OcCkgAqO6wREcy6b++zhN?=
 =?us-ascii?Q?v4x6YnvG+f+uKpVOceMAhq7qF68xfUw/5tCMbPiOuMij3DUKdSTHCZvf+WsK?=
 =?us-ascii?Q?mwn5RbTChTNQWuGs7cn6E0AvMcKXpSSNqCfgtyyNJtsMVxJ5aWMIs4iAsN1H?=
 =?us-ascii?Q?F8N5V3s+EMG3DoFfHyrxeJDcuUQDVUEwAcsMT9UqRztD0SAA5WXxcedda4Pd?=
 =?us-ascii?Q?Krx3oynCJ0FAu9cPNXBPHozofeyeX6g+r6BzL3tbDXnbi/VcTRA8wxe0zb+w?=
 =?us-ascii?Q?e+hquuXTcxjmCqNIH8DNRAHNLPnMRX4gYeM+sEZi0dm/nk9zDPTxd5BfUdyS?=
 =?us-ascii?Q?uCUkm1Yc+9MIg93cJiJ6V9opRX5uv1Rl+VRPSfrLROrCXJPeYvDVjsC1JfbT?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: maozEonQ8OWr2zz3AUU9nwx0gCJ5smd8Mu9CEvGIAKb+7aFkjpBCGu02WkFf03PrXUKcA7FASnIkcJ3yrDOKSv/PJv/cwU2f98Ontuh7HH0ki1ejV7IX43RJ2jAZSbChfP0nC68IZaaOyv0ffMneDJsWgRvnl6uvb+s2/EioMFpW4D5a3zG9aFUBI6yOBmKVKpAdfmNORVTkNxMLKuMedwRNF3JD1ffvbE9xbuOOUZnqlxBVEQe3zUL5tsgk6nO56bPrFoRp+MM9SH3PyG9QoUAc40OBJiuzg9eX6QHgphrxm5pWT0HvinOp5kgcU5e93g0p2gwHo5McOxC70nuVp/JUWE43vAqPKFwFQXgXPTvTK9pqMhFyeLCVG3wBpwMgLZyLuRSVyBQkTwrzQN3J042D/WXamSyE1lIfMEjN0QbXxf1xdaaboqt745i4ZDK+NMpuF/TwgtLKmjGodqOZXmjGMvQhqmhlh43pmt8EQunaN87fVUWjt1RbAyIUbgPMHYoMoac8KhSfiAjgQqBZAvaYFc9Qh51F7ip5SFWUT6GmpI2hJLtgrhf1GGfzY2iFjWn99K/3TlMhTdWHJvbpMBNszwucBVSVGhE3nrG34Kto8Nw8NYZ4eQzttS0y6J/7CvvL4n7FvXidJfftuRt+4NvznFzL7HLXnaFQ2pfZ9em3peNHjYSzWPlOgtIASUpM529q+kuqw0GxH6Zg6PVBxoKn/YpB+xP6kPGR6GAHb6ri8TzVrJLy8u0mJk1+l3ZV+ykWa8/4VwxrZVtS6825R8x5ChFlnxpSh354CVjgL4EhJVmTa2x0Wp8cZje42DmLB6HAsAtsvuSYphW/muTGaT906V0+09PpJX1uuQTIuBdyGYKNl/lY1mYwATUtfiQZMGoD4KeR+aK9Z1qDKPRJuQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cee080-d6ae-4fa0-3258-08db0af7c224
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 23:45:43.5127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YG3RTqIw43ALaehwBbDEjjP372F5S1LeVUHqp2MtnqUooT05tA19zcdsQRkaix80fHbKuwqgAaDkdB1So5Reap8kFR6gPaxY1AJIAsvnQ68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=639 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302090214
X-Proofpoint-GUID: PK_cmpq8iMnAIW7Z_wp_G96wdh6TnTpy
X-Proofpoint-ORIG-GUID: PK_cmpq8iMnAIW7Z_wp_G96wdh6TnTpy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> 1) In effect you have "moving" opcodes that depend on the endianness.
>    The opcode for signed-operation will be 0x1 in big-endian BPF, but
>    0x8000 in little-endian bpf.

s/0x8000/0x0100/.

(Yeah I'm bad with such things :'D)
