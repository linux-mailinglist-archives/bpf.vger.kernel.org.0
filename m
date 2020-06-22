Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873F1204332
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 00:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgFVWA4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 18:00:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39524 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730921AbgFVWAy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Jun 2020 18:00:54 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MM0GQx006264;
        Mon, 22 Jun 2020 15:00:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=oZ7XkKR2T4iJc/YU7bv7izSgjgt33G9egzUVhZX6pkA=;
 b=JeYvjR0/WtRx2Qh+tfexOiKUqjqIj4+JVvl21o7yMUTAzxYRMkXY/r1zXMfkWYmTWLks
 c5qHUBus2WcIOuTuvPHdNlbQYqwXy+bMm8Zbh0jXJB+b5tz1NFAhEeu8dqMIiqJPdz0L
 A/OQyxU0vzm79x9NMgqP/GgmfBR/rtEoNMA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31sfyktjn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 15:00:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 15:00:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLiLRQl+PbbsldQS+/YMsNMfVtNSQdsPbRDs930z1LR2+FrEo3V6laPm8RM9A+wgnP3n/lXX5EDfv+Bkzpr0IQnBtBl+OGg6/DVhyRrXtFLKSkK7/0UssAm+XOXf2UU13dIwTtUVkDsDk7PYh9UBLp8NzBWwxa8IOVsxxT+VcURFFA/vYwBVtXUPoeUhT10cHnvv0JXWJehCwIOTz7KBeyWUOYtdozV9kAxCmcqFQ8YiGYLWELus4yJL+dlc3iQ/UaMhMnfmMd+6foDguIbVvROy1O02ksMfzrM7dynFXj50Gld8tAhSV5U29uY8JP0fk6mI3P3t3g4ZlQKQnwnw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ7XkKR2T4iJc/YU7bv7izSgjgt33G9egzUVhZX6pkA=;
 b=aKydQsTYmj8Q5etBxcMy1Z26q3JNrLNmVhaqmxcmO2W6XtuAiMZciyStmnf6TS1nDnl5ldmMnZK7CJLIdM3aC6lRbwrlRAjCDqxh2kN+54wy9gkrUwlarvUYfPWlVdIJ0E/+T6huLPWQzhYIlrXVAUlg+5iYBD/0i0orDPA1HQrVGKTeUJqrz3wh1ncTB+NBr6fT5yk8Rnw4tshWNvl0U4AmW4IuS0mlysRQBl5n9wut4Xwi3IMyTHgZwh86zClRjEsxce4vgkx/Gw4MaSG+9aAPBdkyNsbRw2Ipx9xPPTk/YbHTaVG0pdXWq1TDxuHkmD90Cfx9uMsXiUOVrm2xPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ7XkKR2T4iJc/YU7bv7izSgjgt33G9egzUVhZX6pkA=;
 b=V04RyLaddwOdMUKivXfrYpiIFpGQeewRP63wJN6M2zBpejzwaI+zj5mlf30p3RzhEgASkadmREgNt8NcwU2qoIW7tJdloeqWgBJBkLtuqHi7ZoAw+aPzir5+uebzHNhkBljeFjPzlKhnwavfm3bYCvE7te0blqwPpAIR00Ph5ic=
Received: from DM6PR15MB3580.namprd15.prod.outlook.com (2603:10b6:5:1f9::10)
 by DM6PR15MB3626.namprd15.prod.outlook.com (2603:10b6:5:1d3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 22:00:39 +0000
Received: from DM6PR15MB3580.namprd15.prod.outlook.com
 ([fe80::88ab:3896:e702:55e4]) by DM6PR15MB3580.namprd15.prod.outlook.com
 ([fe80::88ab:3896:e702:55e4%6]) with mapi id 15.20.3109.025; Mon, 22 Jun 2020
 22:00:39 +0000
Date:   Mon, 22 Jun 2020 15:00:37 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [Potential Spoof] [PATCH bpf-next v2 08/15] net: bpf: implement
 bpf iterator for udp
Message-ID: <20200622220037.e2bocfzro3voykaa@kafai-mbp.dhcp.thefacebook.com>
References: <20200621055459.2629116-1-yhs@fb.com>
 <20200621055509.2630074-1-yhs@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621055509.2630074-1-yhs@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To DM6PR15MB3580.namprd15.prod.outlook.com
 (2603:10b6:5:1f9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:a594) by BY5PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:1d0::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 22:00:38 +0000
X-Originating-IP: [2620:10d:c090:400::5:a594]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec7b3e80-8a24-4e2c-9e29-08d816f7b351
X-MS-TrafficTypeDiagnostic: DM6PR15MB3626:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB3626A20EBCBA8534329C5871D5970@DM6PR15MB3626.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4pJr6+UMylf3n/EGHNIWotFCSryTOvQUCxbyBp/yr+aWMFC4DlU2MImcLlYOswOFx4N4dfTs8jMz1l0sxqBzR2Pio7HIjOk4u2SgCkukuEhPGcn8xc/wiYh5lwuaHfuUCv6ZZcC9fmW7iVfSEHO3m8W2DIWPw7l4ABfiDi0bmjSQGrUeEJlqRurkkmloePTGx7te1hnqtxfvtWNXKpsmkYeoWW4M+hycVhsxNgmzIY+Ikjqzbm2W0oZqwXh6aLfEk9v4QhzCCiJSLXIf3D4ZejZtUjafZweiRUvHtJ9HL3zeISclBVp+lHcczaTW2Vxyn4sszPIRBijKCWgbbwaADg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3580.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(39860400002)(346002)(366004)(396003)(55016002)(5660300002)(54906003)(52116002)(7696005)(478600001)(66946007)(6506007)(66476007)(2906002)(66556008)(316002)(8936002)(4326008)(1076003)(8676002)(86362001)(6862004)(558084003)(9686003)(6636002)(16526019)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QdvT5OLEr9u23TS5Car2Hl9iOs1MpisFb60HIxp9kRzsDPCxbLLQ96aQ+I/j1AOsbeBiegeywpNj/ju4dp0lgJD/uekua0OaZgZRfBGM4r5NXhjl+agMgTHTeSDPO62G32aH0L6zGt4zkb9QZ+/aKtpJuXpTJK1/BSvvTItj+x6F+N9gjMzh2d3rG5hnxFn6MWUsq287vMuw/krMgOBXFVHnKV2s/KcTT76pmE9DWdSX0qk3z1NDQ9s1rtEHaLoVioCkW2c5i0XH0tuUZBSsFKirmmGeF8rksl24qC84kMQR89+wn3x9wdq9Sl5opp/fJ1FoklPHB8mbuPst79+hKpFn2iy3MUyOe+P92xdCRAc1PqDcYBqPQpbEJaFlPEgf66ZTAuWMNr5SSZqy7verU0xZQn5VfexZJmy87L5VDMfc5p7DvRxjOBnP1skTDfnhoMHWLw6W8KE8oELhoOHYlwbrvguntIO37AzLzzPxezDW6+iLojmdPMEEmyPYR8PwKVIlbxw6+Rzn9zB1USFIBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7b3e80-8a24-4e2c-9e29-08d816f7b351
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 22:00:39.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8zvFkAsa/sRXGnvu2kdEWwl7PTe7Fjdtb6vIYN5Lkr3UCweCsyUBBODGPXc289j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3626
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_15:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 adultscore=0 cotscore=-2147483648 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=646 spamscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220142
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 20, 2020 at 10:55:09PM -0700, Yonghong Song wrote:
> The bpf iterator for udp is implemented. Both udp4 and udp6
> sockets will be traversed. It is up to bpf program to
> filter for udp4 or udp6 only, or both families of sockets.
Acked-by: Martin KaFai Lau <kafai@fb.com>
