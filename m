Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E0F263848
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 23:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgIIVPF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 17:15:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36150 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728617AbgIIVPE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 17:15:04 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089LEHUT025287;
        Wed, 9 Sep 2020 14:14:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=aD18qM+SkeboUq1Ri38yaBDrGjx3mQy85bXhUqCpJ6E=;
 b=c+Ha9HvMu67qPtuOHWrJx7TsZN5by81h6f7O2p4SxIXXBToAwVQ6EyUsfJ14UTRDeHnd
 dMiMUAfa5kBbTIMCA7ZadvuIVnvIPVjAxVB1C6S56zHEfTKEQIBt/3jrPyqceuSA5oxV
 AmwubVXtu5+e9/ZzfQpyZ9CMcPXTQXgWJ0Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33efrwpnqv-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Sep 2020 14:14:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Sep 2020 14:14:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afc4kF5jCNm+9E1ClPygYXWcDbm26g8jw7L5WzivQFV2qpymLmA3gZ6A+EFX5uABP58BYJuYsnkiA8bzUSkPQWQYus90tdK5slUjgmIoHabfOk8elWg6jZTj1ISksEDLBiMV7+5HbuGh2eXYbpJXlrwhKcZIXuJbecGu7zVdwB5kBn40HpWtZey2sPr4w9syTc/sCwpbSh2JYr8vnfk9iRlN/guub7npERsGtKac6AwEJraxhtYmJeC+91xJp6il+JMEWpA2ZevLTTBJj0T8UCwZOlR5NBtzW/dnWVNXX4PMLOk12YC6dlCPgkVACHLCy99T/xkK6uknGwras8nlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD18qM+SkeboUq1Ri38yaBDrGjx3mQy85bXhUqCpJ6E=;
 b=IpfsxL5fUgqZd2YjpQSuBcHic3z91TYTGG1q7zpXeLRCQ2Za333mw6AijJP05w122XXX9GyjsIcBcAUDrxy4UgWcXW17jhwpUnmUPz+Jft+KfKAEf37U7bJvu01RVJGJeKjv1B85JXaCJXlBm07SYDXwa4zooEd6VEjMhDAOsJ0E1RE4MQ4XPW0L+fB+wuvdTbD3/P60KG2IMHB/g40zZOC/IJUGidQXydQKAKwr79leZUqyiCQdKIxKMMMiIAT3z454e96S4Gb4C7mfsTMVsXxXUUhoVF7IxiENIcvs+umK2irwsfiniRwyhkLZCxEtzcfY5yhTLnizSd/atLYS8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD18qM+SkeboUq1Ri38yaBDrGjx3mQy85bXhUqCpJ6E=;
 b=S/SFKMZ+9p7kmg/q0y971jeynseuS2wo+gkNQ3TDP65czfXUoT/UxdTdftkItO+2U81oUlG8+xcugd0nrm8BWoNIwWQuUkOMgXQYtLYLEhTZK9rOVwCMTxXqJOvFtymoTNbAVXXMwCyHTbOIvnOraWcOSGyUFQ7cLgz/vWypRp8=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2456.namprd15.prod.outlook.com (2603:10b6:a02:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 21:14:46 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 21:14:46 +0000
Date:   Wed, 9 Sep 2020 14:14:39 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <bpf@vger.kernel.org>,
        <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 09/11] bpf: check ARG_PTR_TO_SPINLOCK
 register type in check_func_arg
Message-ID: <20200909211439.r7av3zkeecer54ti@kafai-mbp.dhcp.thefacebook.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
 <20200909171155.256601-10-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909171155.256601-10-lmb@cloudflare.com>
X-ClientProxiedBy: MWHPR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:300:116::29) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:f23a) by MWHPR07CA0019.namprd07.prod.outlook.com (2603:10b6:300:116::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 21:14:44 +0000
X-Originating-IP: [2620:10d:c090:400::5:f23a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f9a0a40-0efe-46c7-6d50-08d855056062
X-MS-TrafficTypeDiagnostic: BYAPR15MB2456:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2456E14D0A2271A048958A78D5260@BYAPR15MB2456.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hO9nswmU5Z+iN8b/34dF1gTM2wqrOE3f8wkAh35O30DLFvikgw7tKFmutd/rh/Fz8mTE74CvHKLnglfB5FgSWJkZhkH9oxkjOII/+T0BI7t5bshRVQSCJ80KTkSr4E77bF3KT1d0RuE22zRBS06epFUBMX3H7x6a3xSsLcskSAOt+MUd5Ud7M5wzlp/fgfuKIK67/vdOsP0TI7S3P0SqPR5s03NsM7AHuJZuTP3WonkwpB0FU4U3/ZEYi6JYvYFeCS1MXLH/Z+lUjFTG9FeuI5+0LNtKZYX76V8hBjrW6iPnqG7TZa+5hUNrgJF3tC4RhPYzid7su+mx/nwcYtlFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(136003)(366004)(39860400002)(66476007)(55016002)(4744005)(66556008)(5660300002)(52116002)(1076003)(7696005)(8936002)(8676002)(6506007)(316002)(9686003)(4326008)(6916009)(16526019)(478600001)(66946007)(6666004)(186003)(2906002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tC2g1NJgcbq+zEMUC0yIuNRGS+Aeg8UPTP327xnjbsuffx/hcbRks1fyR6Py6uy4ll1NMcxRzsLJwrghdNW78cL9+CHt3rujUizryazgWd2e60oxJn6glLdMCyYc7KDKes9KYEHE9YgTEiNFEF0XDL/yjhthIoAwcWpyU5bz7mzhttBaI8Vwsjlf0XKyLYQH3JhuNwDN1hHposOgPoLLzPZ9W03CS1KSE12grzfogdrB47pRWDefUaB2m7v98vS0hZCTQdLceiE/xZ2cse+g/qz+KawIy1q4VyHBUw/Y0X1VI6ZVM6wVYUa4ACWn7mnLaejroH6IjDUsmGH8UjCBcB2T8ch+EwoclU4pLaEiHfPeaTbpOmpGZTS3CQ+m9fcH9Qg0/EETphA/Sy642JfiazRrb709RxTQCjHwG0RSt5To4EgnMM+mtm1jtMrBxz5g+aztz1/hOwqYP3oZO8b+/rDcjHyH/XBf1HyX9rTw0NOJVlOR6JZ20vM3va4OHdfZa1pjbRVgDIJ3joeiQq7gzKVvjpBYpE35yNcue6lqKoHXmC+G7PiSDTvLiyh9Q7+HoPpBEc74gpa4HhdmqQgVY53hhImm/LE4mONw53jd+0y2r0EBvFh9QLFdvjYK02RTY9PUUa876VVASmWayv9dXkXnoMwiHif7I4Rq9ZN46NM=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9a0a40-0efe-46c7-6d50-08d855056062
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 21:14:46.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBWMrwd5hOU0vOGa/GOoueVpy9pfhaZaboTAl+86SpVjgBnsoCMiqDdkJUuEkteE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2456
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 suspectscore=1 clxscore=1015 priorityscore=1501
 spamscore=0 mlxlogscore=835 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009090188
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 06:11:53PM +0100, Lorenz Bauer wrote:
> Move the check for PTR_TO_MAP_VALUE to check_func_arg, where all other
> checking is done as well. Move the invocation of process_spin_lock away
> from the register type checking, to allow a future refactoring.
Acked-by: Martin KaFai Lau <kafai@fb.com>
