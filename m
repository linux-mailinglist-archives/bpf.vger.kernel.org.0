Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CCD3AB78B
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhFQPc5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 11:32:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45700 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231661AbhFQPc4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 11:32:56 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HFSrI7031751;
        Thu, 17 Jun 2021 08:30:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=I7m7ilfhGUdHiG3MhJW/0wi0EgcNeBht5D3e/OpkMC8=;
 b=V8XQAkL+UIvjyQa4SDVJv+/9Ykd8a670+P6OVCUy6Jz/KnCrSqBPr4Kp0djc87yjRF9J
 qmp6wKs5EWanZA/BrSo4FvYwwu7wl1dn7Fq1DhdTOwMi4CQZuVIdvVM6YEuh6NsC8ODf
 2lguKiTr0hV6krpmxK8cnRLDFuTn6sy7qzc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 397hbarr5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Jun 2021 08:30:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 08:30:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzw6aBiTCHTg2OJNzcel/RIxEb3WL6MXGa+bBKQm9HUkqRH7eIiMiGUXiwlxi4XYReF5RBqvdtotFUIqi3G1en43cqDmXqtaSQdj3MHrD+AXSJSlQNdGn3ZAYivWvz/6eRu9ByxrE3XaZlQWT+/MCNlQj8EtU9xRP6nPK+tpycRkEZn2ndfqVWibFL9wr5htSko06AOWrWigPjo08/c1j4PyF4latcI9Wy205mRefPB+0ZK/ZtmWKB/fgevSsLEqYhtIzsGCYLL1t9ZASVPuBrgqz5Rv1LJoTh3dRjpGuC5BdykYlDQJlXmAsJI0qas9Qk+gj5dUj5mIIUXGPmVgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7m7ilfhGUdHiG3MhJW/0wi0EgcNeBht5D3e/OpkMC8=;
 b=H2dBTFdI1TsPKgwo7V9sOcAI49zb32DliQ71nk3HgSqeDnjuHtMLN16V27SWy7ollq7Cf1T5HIL/2R3XO4Y5cB5frpaP+e0ZvSgnzQF+Zck2I7CahB4zv5g41QWbVMW+gjzRLQ+spVMbnHm+/u4Ji4D0NeJiwQuzcxVtBz0WsPX1VjRrZSh6P5+xXEJmaw7pQ66NIaAXw6MAowV00/PSGCDJF4pnABPQuzM2wWDBrHn0cYs5Wyn7PmKT2RqNq6NaRUm5i1lKlITtSmPeuLQ6SoIsHzWKpuHud3n1lEI+O6KredxZQ6Aw2xb1cxUptnHtqJ8h7eFzD2q+3scBudrOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM6PR15MB3561.namprd15.prod.outlook.com (2603:10b6:5:1f7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 17 Jun
 2021 15:30:24 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::b0e1:ea29:ca0a:be9f]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::b0e1:ea29:ca0a:be9f%7]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 15:30:24 +0000
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add test for xdp_md
 context in BPF_PROG_TEST_RUN
To:     Zvi Effron <zeffron@riotgames.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
References: <20210616224712.3243-1-zeffron@riotgames.com>
 <20210616224712.3243-5-zeffron@riotgames.com>
 <5ff53b96-775e-c0af-8b83-d1e366fb2d3c@fb.com>
 <CAC1LvL2-v9AjUkakw4Mq6-X-80FrFeSrHNa3p2nrVzxXS0C7VQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1c8681a5-527b-7701-7b15-88f4e4aa54f1@fb.com>
Date:   Thu, 17 Jun 2021 08:30:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAC1LvL2-v9AjUkakw4Mq6-X-80FrFeSrHNa3p2nrVzxXS0C7VQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:3b8a]
X-ClientProxiedBy: BY3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:254::8) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::12bc] (2620:10d:c090:400::5:3b8a) by BY3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:254::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Thu, 17 Jun 2021 15:30:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 266f8b1e-e3e6-4418-f865-08d931a4d34d
X-MS-TrafficTypeDiagnostic: DM6PR15MB3561:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB3561D4FA1F35BD8BF1661162D30E9@DM6PR15MB3561.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2E/vYr4VTtbaNwCYsYmAFajQKBkFjn84GtNGMHmoiqps+mzJr7KIwvDm4d+jX16v1zI458fbgzehHGkb2Ywe4HQOTxds4JvlakOraxq5IIEocLuq08rEvKkemZlxphgC9THUoot9IrPoS6k6g9xD+NbOZgHMc0ErFlqsmw+R5GUBD7yBxTjJs/27G3rUt03IISYJppmQozZR4iGu2lZdB4kNHAU217O20RVuTI826QNpPDEh6WIh95bp3BIiHgKFy5Kb70+zUuesDmJq31BUoXGrB/KnQjaAPkSTdPFinyzbhtzhq8GuKMatlKPyspq4s4gunG2D0ODz7Dqi9u0MDDn2LSslQa5qKH+RrGoGBaC+jqRhYvz7jm4cEMB7eWfG4xsmxqzx/sZq6sbp/h/TGK+1lXHYDwQI/d4tF47y/uy1vJsTHJqp9ywNGvpKFBRXKHDVmd6azR3sGX+e//D9mp5bjku7frutpPy323+fEbH71a+p/YMD3Z91LEFa7ySpUeyTcgaICH4SKK3wdahs2qFLfNfeOXCml68UhmIHyL+FelR2EI8dIIERVRMIW+G7EdlssrKRmSjYxNo2LEh+QrT/ArfNAje0Fi4PVJHKxThbtasB6iAVtSul0PEoj0BgchKOH6HtPvgyJvZOG0Fv3YZoDzGjskUAoZKmEEbO1kyr8zQXt+uWhl7sTirXz4O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(2616005)(186003)(4326008)(66476007)(316002)(478600001)(5660300002)(7416002)(8676002)(86362001)(54906003)(36756003)(6916009)(16526019)(31696002)(38100700002)(83380400001)(6486002)(31686004)(52116002)(8936002)(66946007)(66556008)(2906002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm5UditiRXFVcVNZaWpOTHc5QkpWN2U3K1dHSWY5QjBrcGtlL3ZBZUVjRFBt?=
 =?utf-8?B?ampMTXdoQWx6M2FRSXlrYytFdlRQdGNzNks0NGtKSGxmaXF0ZkgydjNLdnlr?=
 =?utf-8?B?eXFiK3Rjc250cGRaUjExQzBBYlhuQmVhejN1RlRGdTVOLy92ZzloY3RHUjBr?=
 =?utf-8?B?TVZJckpIL2V1SE9GNVJGMjZGc3dSZ1pUUnpmb0NnS3hmcHR1YlVqem1xaXJK?=
 =?utf-8?B?cE9zTUxKemkxTTEydllsVlYzb3NWTEhlSGtVSEVlbVVwWitYOWtGa1E2Ulgx?=
 =?utf-8?B?SkE4WmZUUnhMTkVtaEhrTURaTU1nV2Y5aTlmODFPUWpQbnFDRng0YXJTRU4w?=
 =?utf-8?B?UVhsUnNINEZjVnhBN1B2aG5BL2JxR2cyVVNuZFNDYzY4ZHdKbVJzbWJhK2lL?=
 =?utf-8?B?Qy9kR1AraE1VY2NEY25yZ2J3akk2cS9LVjl4UHhENGkrTXF1b3hjUUpONTdp?=
 =?utf-8?B?L25WN0ZtVUpKaEZ0a01RTzRPeXFzSURqNWxzYmJCWVFqajdndjQvRkZpNytX?=
 =?utf-8?B?K2dkTWYzcnFZK0RvU1BublRTREhRazZPQmhWem5IUkdnTU40WGRZS1MrWE5E?=
 =?utf-8?B?VEwyRk9Gd01qYkc2VXNRbU5FcFZoUmcwMmFjMjNPV2drRHV1dVdkSUdCd0c4?=
 =?utf-8?B?dHJIM1ZrVTRibVdlSzNkMWY3WnNQK2tJWUdVRE5rdnFkQlZqRnNXWERGRzJZ?=
 =?utf-8?B?ZnFGVmRUdTI5MzVvWTFFSG5qbVJoRUNrUjlrYllsSko2WEorR1lWSGRhaGlu?=
 =?utf-8?B?bGNtMlRjK0ZTS3JXL3ZaZ2JydkFMNkRwOXdielJDeVNqNE51Qzl5VzRFcC95?=
 =?utf-8?B?WjJxMEdwOVlSdUk0cHZQN0VrVDJWMmhWUVJnbVkweEpGMk9xNU1sdDlYeGRI?=
 =?utf-8?B?WkVqbFQzWjI1bmpVcmpVZXp1RitJNEpDZ2lZUWRhc01RV1Z6R1R0TzFtRG4z?=
 =?utf-8?B?aHoreG9RamtybSs1U1ZPMHpRRkpwc1h3MlFvb013VEFPUlBURzhkdzNoYmpY?=
 =?utf-8?B?NEpmNzh5Z2NNbGtFVXQzcUYwSTR3aUlmaXBDVVRrdkZVMnZaZHhjRW9Rb1Ro?=
 =?utf-8?B?NVJZRW0rNzJhL1Y2SlVlNlNOSjcvcTZNemFUUzhhU0NsdFNwcTIra095Tm1n?=
 =?utf-8?B?Vi9BMlZrbFhFbzNGNDBtditzMGtzS2FHWXRuMGE2UUR0Smdzb01XMkFVRTNW?=
 =?utf-8?B?N1ZTdWNZSWQrMk5rVU9GeGYyQ3dKN05ZSHcrVnFWMWR5Z3JNVHI1bkdXYlFq?=
 =?utf-8?B?NzdRbG9qcmwyaDBBbVQzY1dkSkk2M0c3ODQ3VHdxcmN3aHRCS3dWUjlZN0J6?=
 =?utf-8?B?dEN3U2RyTWZNMkIveVltR29tZEVtNnlUdzFUOXNxWm83Ty9CM1N2Rnc0WnQv?=
 =?utf-8?B?RGUzcDd3dWVNeUVYM2tCS2Nzd1hGNWg3NHpiU2VFdnpRSnNLRVZ4ajZkR3Jt?=
 =?utf-8?B?Sk83WDlnYXBmZEpCeVNJdEk0dzFqa1RCZzNUbWR2Qko4NVpvVGMrM1NrU2Za?=
 =?utf-8?B?ZTVmNGcyL3hkNkN2dmwwbGErME1Cd1doMU9VWmNGVVR0MlNIbUZRZlpSaXVs?=
 =?utf-8?B?Qmd3dlIrQVhlSy9qcU54MmZLUi95ZCs2U1NmQW90d2RCcXVGYXp2NXBabUha?=
 =?utf-8?B?UmU1RXA3WnNvTFZwcHF4QkJqQVZZZkRIaDZla21WdTBJNGs4d0U1cml5QW1p?=
 =?utf-8?B?QU42YnFYMFM1c0M3eno5YWI2QUJMc25sU2F5NjlvcTNlOXF1bnJJK1o5S2tD?=
 =?utf-8?B?anVYa1ZHcXhJclhMVXF2ZGMzVWY0MCsxTDZkQ2N1VmFaRHBMdk5adS9JTSty?=
 =?utf-8?B?TUFpaml4cU5XMEJOWkg0Zz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 266f8b1e-e3e6-4418-f865-08d931a4d34d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 15:30:24.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Muym8+e43aPYAJ1iw35CIVz1oh2efPRlHBTOstxdUkioy1oenaM8vFEqijHpb0wi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3561
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: LfBJRsGhtrl2qYC0Eskhs1p1VEKbSxfn
X-Proofpoint-ORIG-GUID: LfBJRsGhtrl2qYC0Eskhs1p1VEKbSxfn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_14:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/17/21 8:18 AM, Zvi Effron wrote:
> On Thu, Jun 17, 2021 at 2:11 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> On 6/16/21 3:47 PM, Zvi Effron wrote:
>>> Add a test for using xdp_md as a context to BPF_PROG_TEST_RUN for XDP
>>> programs.
>>>
>>> The test uses a BPF program that takes in a return value from XDP
>>> meta data, then reduces the size of the XDP meta data by 4 bytes.
>>>
>>> Test cases validate the possible failure cases for passing in invalid
>>> xdp_md contexts, that the return value is successfully passed
>>> in, and that the adjusted meta data is successfully copied out.
>>>
>>> Co-developed-by: Cody Haas <chaas@riotgames.com>
>>> Signed-off-by: Cody Haas <chaas@riotgames.com>
>>> Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
>>> Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
>>> Signed-off-by: Zvi Effron <zeffron@riotgames.com>
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
> 
> Thank you for all of your feedback on our patchset.
> 
> Question about process for Acks: do we add your Acked-by line to the
> commit message in our next version of the patchset?

Yes, just add my Ack to this ack'ed commit in the next revision. Thanks!
