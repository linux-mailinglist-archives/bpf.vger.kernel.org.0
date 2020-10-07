Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F27285886
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 08:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgJGGN1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 02:13:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15920 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbgJGGN1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Oct 2020 02:13:27 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0976B7h7021698;
        Tue, 6 Oct 2020 23:13:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=vjc2rnCiN6QO+ioku5WMVPXWXgfQ2UsYzhfyew30qbY=;
 b=B4xghudAF+0X4lZ0NCijk5CGfEKNakAU2lVitFkYXYPxM+eC5rCSq8Et1uai4NVH1fQG
 U9lpLAXFJ1CbSRiO7rS1TgjjqiC/IjWnTEyRuZpFrJDM6S2h7ImA8Td8mtFJNm6cfXWJ
 05Xhr/FFMTNw8vEOv8rTMXZcHTnW8MUqBAY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33y8t9xqsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 06 Oct 2020 23:13:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 6 Oct 2020 23:13:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lN/JKpuDaVLUUxnlx0zDe6woQr+z3wgu85VeL/m8cYwC3fEgoDJGvdjCWzb4D2lK3pu2kx/68aqkN1gfQ9cHqkJJxjJPXofZHhpsRi6I5aOTDHf0Kr3E0i0R9fKl5ZQmr3HViGmI2GCavTNSOqgJYuXOwD0ifA7RWfcOscqhIEQl9o3q19CBH6jTbxoFA85Pm6HmXuO9gNtown46QnwtbJPJ0ud+HH3JL2dn4sTASCAnZlDdD/IMQ/3+aqHAlpuyi6+z8OHJ4G0nYsFnKmlnO2eqyGjD7Wi56BteAeWnyQgjCFbQGNhBW5sLEYuaq5JwK3gf8k4jOW9H7FeoCHrg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjc2rnCiN6QO+ioku5WMVPXWXgfQ2UsYzhfyew30qbY=;
 b=HTfhPaIQ3c+hIIwy1/WsIu0Ff1+VcUhi7iMS3P89CnmZquhCH330xkxXu2bocKn5RdFEjZiPZRwXwm14lYL95nvO8L/dbt1NvFpXmRIBRa6SYHiMIWCr0ZZPt5K987V/SIKIqN7fpftTIf+JSquG/lMeBglaW4K3jtH5fos4uSj0Fd2VuTAgoi6YCrwOMEXlFU9ItPNdN+Ff1uWMPv1uNTamfjxdH4Ww4cZkluUQX/n+7va1+IUzSAXy7tuIg8wEUp3wcXLHt1YLUWBL/xazPqNZ5RY/ecBjnQ14snvY8X6NOgAWpSklkEQ9WGohbo8CgP3F1p3xckBLEhZdjETr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjc2rnCiN6QO+ioku5WMVPXWXgfQ2UsYzhfyew30qbY=;
 b=lBDyqiM/Y90tzbIsUIEEETz1y8vsroWLn5L8BOeEueP5JpsOc6ubwRd9TBuOYzCLMGnocmhxFwP7WdvD26npeGYP8CNXpSiq0mmxcqT1ZS+toYzZ6LNfAfWo+T8a7UMcWAh8KoRNkbtRv3mjjzfOYXJUvYohCmc2UeJcNDC1vmw=
Authentication-Results: riseup.net; dkim=none (message not signed)
 header.d=none;riseup.net; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2885.namprd15.prod.outlook.com (2603:10b6:a03:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 06:13:03 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3455.023; Wed, 7 Oct 2020
 06:13:02 +0000
Subject: Re: [PATCH] bpf: Fix typo in uapi/linux/bpf.h
To:     Jakub Wilk <jwilk@jwilk.net>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     <linux-man@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Samanta Navarro <ferivoz@riseup.net>
References: <20201007055717.7319-1-jwilk@jwilk.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d3e2c2d3-ba90-000d-9ef8-68cc3f6e2a12@fb.com>
Date:   Tue, 6 Oct 2020 23:13:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
In-Reply-To: <20201007055717.7319-1-jwilk@jwilk.net>
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:757]
X-ClientProxiedBy: MWHPR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:301:4a::29) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::121a] (2620:10d:c090:400::5:757) by MWHPR1201CA0019.namprd12.prod.outlook.com (2603:10b6:301:4a::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 7 Oct 2020 06:13:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c0be072-a434-4282-c5bf-08d86a880c2f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2885:
X-Microsoft-Antispam-PRVS: <BYAPR15MB288529F0AEF46656465CA364D30A0@BYAPR15MB2885.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hVIqhfK7wYuUsMKWbB9Xs49KtgbFboG91kXR62hUZT/kYpnmqingDNL+kbX+btjZJpuSrdzBsCnPoQlMZcD7/QjXkzR7cakStCgHCfzHqIjymP9BmklsMdgl/4hAfRgXtwJzuSuTvclHrns23qXN6xk6iWWTcdezq5QHnBS+y6oX8ap7865FwmLL4In7DumZ7GdAaBYl/FZ0awIGnJi1AKwy+sFCQunoy9GrVYrFtZJ2qN3cpGhL86v6nHjgDyNunTXQ12Y3PigAVAUQjiP6vACjrGMNjY7TVlb48OP1wOFInVfpdAo/+HFzTZKKdiB6W5N/6lnI/ucDrsiSWBEPCJp/VTtgU+HPlBxgtjg+QEE82zS8k4y7V4Vy9oO3LP4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(39860400002)(136003)(16526019)(2616005)(478600001)(66946007)(86362001)(66476007)(66556008)(31686004)(8936002)(52116002)(558084003)(5660300002)(8676002)(186003)(110136005)(6486002)(36756003)(316002)(4326008)(2906002)(31696002)(53546011)(54906003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: FIqsvR7FL6cHfawb5nhld5l/c350XU/abt2aJQAOaAWbI6lW+3zLE0mgvdpK3Hgo65ddlZJsW07AFX0BYtYOH4fwIhYRIAn3zM2aQXshmU8lWV5X5CGx1eJ6X/FBJc1/oCAF6O5YoFKMtgQRVtIjzK7uD9XadMUrUjLK829HNyEpYIjbJarZr7Ha1LAtnUCJtizlPXZAUTS4utl8LTCACzaDrxuoUo5NCtBDrO5heBjTkrIwRhdf2FReJK5IxS4Rw+WGy6gi6klNjM2CXNJ3v4rDu7mUbKfKexJUmnQnHvotcAR8ZsVPYJFtyka3XVVXHf6XQ5OpD/f/v6+eB7pJrJuLmOMo3dQTRBROrN+lmPyI9c9jh5Ohcv3xU5OnQciKMcdQJeKZzUGhbTbb+502gOz9j7LV9x1dycmePKk83KLgQp9qv9CuuUS8muGSHBk25j0BcRpUThhFEGZR4FyGnHBKHF9mL0MGT1pxqWyMbKAjZgjC1E3j+baszDydFnJnut5z/IqfolpuxJcO6JfowRcns08lgooXCmF+WN/tu5ftBDweWJe+U8buElCIaQ1FQ5Ueg5rImxrWO/q/+W7EsIXup6lykPmjpqWcVgN0sWFBKnJ7U6+XaTo2zjfNr5slv1g5wV7uUAJ+1ITr+2d4dai97YqO8sn2zUhwmY8Xf+U=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0be072-a434-4282-c5bf-08d86a880c2f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 06:13:02.7497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNGzXPlERCF/mOyWVKZMOMSXt1UyKODHrFpOaO90TWiFqboaodiAtQySpQyI8LKR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2885
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_04:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=875 bulkscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070041
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/6/20 10:57 PM, Jakub Wilk wrote:
> Reported-by: Samanta Navarro <ferivoz@riseup.net>
> Signed-off-by: Jakub Wilk <jwilk@jwilk.net>

Acked-by: Yonghong Song <yhs@fb.com>
